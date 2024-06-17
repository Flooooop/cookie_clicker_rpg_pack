#version 150

#moj_import <fog.glsl>
#moj_import <util.glsl>
#moj_import <colours.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform vec2 ScreenSize;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in float transition;

out vec4 fragColor;

float GameTimeSeconds = GameTime*1200;

float circlejerk(vec2 point, float size, float time) {

    point.x /= ScreenSize.y / ScreenSize.x;
    vec2 pee = mod(point + size, size*2.) - size;
  
    float value = 1.;
    for (float i=0.;i<3.;i++) {
  	    for (float j=0.;j<3.;j++) {
            vec2 center = vec2((i-1.)*size,(j-1.)*size);
            float r = (point.y - pee.y + center.y + 2.) * time;
            r *= size;
  		    value = smin(value,length(pee - center)-r, size/10.);
  	    }
    }

    return value;
}

void main() {
    
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

    if (transition != 0.) {
        
        color.rgb = vec3(0.);
        float time = vertexColor.a;

        vec2 uv = gl_FragCoord.xy / ScreenSize * 2. - 1.;

        if (abs(transition) == 1.) {
            float size = 0.25;

            float value = circlejerk(uv*transition/abs(transition), size, time);
            color.a = pow(max(0.,min(1.,-value*5/size)),10.);
        }

        
    }
    

    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
