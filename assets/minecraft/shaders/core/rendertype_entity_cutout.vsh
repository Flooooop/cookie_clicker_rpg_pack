#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <colours.glsl>
#moj_import <util.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform float GameTime;
uniform int FogShape;
uniform vec2 ScreenSize;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;
out vec4 normal;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    texCoord0 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);

    int gui_scale = guiScale(ProjMat, ScreenSize);
    int id = gl_VertexID%4;

    if (Position.z > 275 && Position.z < 300) {
        vertexColor.rgb = vec3(1.);
    }

    if (Position.z > 400) {    
        vertexColor = vec4(1.);
        vec2 factor = ScreenSize / 36. / gui_scale;
        gl_Position.x = round(gl_Position.x * factor.x + 0.5) / factor.x - 18 * gui_scale / ScreenSize.x;
        gl_Position.y = round(gl_Position.y * factor.y - 0.3) / factor.y + 8.2 * gui_scale / ScreenSize.y;
    }
}