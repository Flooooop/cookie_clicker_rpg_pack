#version 150

#moj_import <colours.glsl>
#moj_import <util.glsl>

in vec3 Position;
in vec2 UV0;

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float GameTime;
uniform vec2 ScreenSize;

out vec2 texCoord0;
out vec4 vertexColor;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    texCoord0 = UV0;

    int gui_scale = guiScale(ProjMat, ScreenSize);
    int id = gl_VertexID%4;

    vertexColor = vec4(1.);
}