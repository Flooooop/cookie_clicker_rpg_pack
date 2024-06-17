#version 150

#define PI 3.14159265

#define FOG vec3(166., 119., 73.) // #A67749

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
    if (isColor(fragColor, FOG)) {
        
        float trans = length(vec2(gl_FragCoord.x - ScreenSize.x / 2, gl_FragCoord.y - ScreenSize.y / 2)) / ScreenSize.x;
        trans += 0.2;
        
        fragColor.rgba = vec4(0.92,0.92,0.92,trans);
    }
    
}