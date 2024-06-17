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

out vec4 fragColor;

float GameTimeSeconds = GameTime*1200;

void main() {
    
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator; 

    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
