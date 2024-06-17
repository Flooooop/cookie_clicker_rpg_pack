#version 150

#define PI 3.14159265

#define FOG vec3(166., 119., 73.) // #A67749
#define FLASH vec3(212., 212., 212.) // #D4D4D4
#define FEAR vec3(134., 87., 73.) // #865749
#define MIMIC vec3(166., 113., 78.) // #A6714E
#define EVIL_FLOWER vec3(71., 76., 44.) // #474c2c

#define LIGHT_PURPLE vec3(255., 85., 255.)
#define DARK_PURPLE vec3(170., 0., 170.)
#define WHITE vec3(255., 255., 255.)

uniform sampler2D DiffuseSampler;
uniform float Time;
uniform vec2 ScreenSize;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

bool isColor(vec4 originColor, vec3 color) {
    return (originColor*255.).xyz == color;
}

void main(){
    fragColor = texture(DiffuseSampler, texCoord);

    if (isColor(fragColor, LIGHT_PURPLE)) {fragColor.a = 0.2;}
    if (isColor(fragColor, DARK_PURPLE)) {fragColor.rgba = vec4(0.6, 0.0, 0.4, 0.7);}
    if (isColor(fragColor, WHITE)) {fragColor.a = 0.2;}

    // DO NOT UNCOMMENT ITS THE SEIZURE ANTI F1
    // if (isColor(fragColor, FLASH)) {fragColor.rgb *= mod(Time*1000, 2);}
    

    if (isColor(fragColor, FOG)) {
        
        float trans = length(vec2(gl_FragCoord.x - ScreenSize.x / 2, gl_FragCoord.y - ScreenSize.y / 2)) / ScreenSize.x;
        trans += 0.2;
        
        fragColor.rgba = vec4(0.92,0.92,0.92,trans);
    }

    if (isColor(fragColor, FEAR)) {
        
        float trans = length(vec2(gl_FragCoord.x - ScreenSize.x / 2, gl_FragCoord.y - ScreenSize.y / 2)) / ScreenSize.x;
        trans += 0.6;
        
        fragColor.rgba = vec4(0.05,0.05,0.05,trans);
    }

    if (isColor(fragColor, MIMIC)) {
        
        float trans = abs(gl_FragCoord.x / ScreenSize.x - 0.5);
        trans -= 0.1;
        
        fragColor.rgba = vec4(1, 0.6, 0.0,trans);
    }

    if (isColor(fragColor, EVIL_FLOWER)) {
        
        float trans = length(vec2(gl_FragCoord.x - ScreenSize.x / 2, gl_FragCoord.y - ScreenSize.y / 2)) / ScreenSize.x;
        trans += 0.2 * (sin(Time * PI) + 1.);
        
        fragColor.rgba = vec4(0.75,0.16,0.17,trans);
    }
    
}