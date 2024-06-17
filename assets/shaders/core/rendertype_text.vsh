#version 150

#moj_import <fog.glsl>
#moj_import <colours.glsl>
#moj_import <util.glsl>

#define PI 3.14159265

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;
uniform sampler2D Sampler0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform float GameTime;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out float transition;

float GameTimeSeconds = GameTime*1200;

void main() {

    transition = 0.;

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    int gui_scale = guiScale(ProjMat, ScreenSize);
    int id = gl_VertexID%4;

    if (isEither(Color, NO_SHADOW)) {
        vertexColor.rgb = vec3(1., 1., 1.);

        if (isShadow(Color, NO_SHADOW)) vertexColor.a = 0.;
    }
}