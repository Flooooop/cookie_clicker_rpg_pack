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

    if (isEither(Color, HEALTH)) {
        gl_Position.x -= (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(215., 39., 68.)/255.;

        if (isShadow(Color, HEALTH)) vertexColor.a = 0.;
    }


    if (isEither(Color, AMMO)) {
        vec2 center = getCenter(Sampler2, id);
        center.y /= ScreenSize.y/8./gui_scale;

        gl_Position.y = 0.-center.y-(100.*gui_scale)/ScreenSize.y;
        
        vertexColor = vec4(1., 1., 1., 0.666);

        if (isShadow(Color, AMMO)) vertexColor.a = 0.;
    }

    if (isEither(Color, AMMO_LOW)) {

        gl_Position.y += (gui_scale*120.)/ScreenSize.y;
        
        vertexColor = vec4(1., 1., 1., 0.666);

        if (isShadow(Color, AMMO)) vertexColor.a = 0.;
    }

    
    if (isEither(Color, STAMINA)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(88., 160., 140.)/255.;

        if (isShadow(Color, STAMINA)) vertexColor.a = 0.;
    }

    if (isEither(Color, STAMINA_LOCKED)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(88., 160., 140.)/255. * (1+sin(GameTimeSeconds*6))/2. + 
        vec3(215., 39., 68.)/255. * (1-sin(GameTimeSeconds*6))/2. ;

        if (isShadow(Color, STAMINA_LOCKED)) vertexColor.a = 0.;
    }

    if (isEither(Color, COLA)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        
        vertexColor.rgb = 
        vec3(247., 118., 34.)/255.  * (1+sin(GameTimeSeconds*6+ gl_Position.x*20))/2. +
        vec3(254., 174., 52.)/255.  * (1-sin(GameTimeSeconds*6+ gl_Position.x*20))/2. ;

        if (isShadow(Color, COLA)) vertexColor.a = 0.;
    }

    if (isEither(Color, DEVIL)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(163., 18., 81.)/255. * (1+sin(GameTimeSeconds*6))/2. + 
        vec3(199., 28., 79.)/255. * (1-sin(GameTimeSeconds*6))/2. ;

        if (isShadow(Color, DEVIL)) vertexColor.a = 0.;
    }

    if (isEither(Color, SKELETON)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(227, 134, 140)/255. * (1+sin(GameTimeSeconds*6))/2. + 
        vec3(227, 182, 185)/255. * (1-sin(GameTimeSeconds*6))/2. ;

        if (isShadow(Color, SKELETON)) vertexColor.a = 0.;
    }

    if (isEither(Color, FREEZE)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        
        vertexColor.rgb = 
        vec3(133., 226., 255.)/255.  * (1+sin(GameTimeSeconds*6+ gl_Position.x*20))/2. +
        vec3(206., 236., 255.)/255.  * (1-sin(GameTimeSeconds*6+ gl_Position.x*20))/2. ;

        if (isShadow(Color, COLA)) vertexColor.a = 0.;
    }


    if (isEither(Color, SHIELD)) {
        gl_Position.x -= (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(255., 255., 255.)/255. * (1+sin(GameTimeSeconds*-6+ gl_Position.x*200))/2. +
        vec3(237., 239., 242.)/255. * (1-sin(GameTimeSeconds*-6+ gl_Position.x*200))/2. ;

        if (isShadow(Color, SHIELD)) vertexColor.a = 0.;
    }

    if (isEither(Color, SHIELD_LOCKED)) {
        gl_Position.x -= (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(255., 255., 255.)/255. * (1+sin(GameTimeSeconds*-6+ gl_Position.x*100))/2. +
        vec3(255., 150., 150.)/255. * (1-sin(GameTimeSeconds*-6+ gl_Position.x*100))/2. ;

        if (isShadow(Color, SHIELD_LOCKED)) vertexColor.a = 0.;
    }

    if (isEither(Color, MANA)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(224., 141., 188.)/255.  * (1+sin(GameTimeSeconds*6+ gl_Position.x*20))/2. +
        vec3(240., 187., 218.)/255.  * (1-sin(GameTimeSeconds*6+ gl_Position.x*20))/2. ;

        if (isShadow(Color, MANA)) vertexColor.a = 0.;
    }

    if (isEither(Color, WARD)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(0., 179., 179.)/255.;

        if (isShadow(Color, WARD)) vertexColor.a = 0.;
    }

    if (isEither(Color, CARDS)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(114., 204., 73.)/255.;

        if (isShadow(Color, CARDS)) vertexColor.a = 0.;
    }

    if (isEither(Color, CLOAK)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(115., 29., 53.)/255.;

        if (isShadow(Color, CLOAK)) vertexColor.a = 0.;
    }

    if (isEither(Color, STRIKES)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = 
        vec3(158., 40., 53.)/255.  * (1+sin(GameTimeSeconds*3+ gl_Position.x*20))/2. +
        vec3(128., 19., 32.)/255.  * (1-sin(GameTimeSeconds*3+ gl_Position.x*20))/2. ;

        if (isShadow(Color, STRIKES)) vertexColor.a = 0.;
    }

    if (isEither(Color, POOP)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(245., 175., 71.)/255;

        if (isShadow(Color, CARDS)) vertexColor.a = 0.;
    }


    if (isEither(Color, BG_LEFT)) {
        gl_Position.x -= (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(1., 1., 1.);

        if (isShadow(Color, BG_LEFT)) vertexColor.a = 0.;
    }

    if (isEither(Color, BG_RIGHT)) {
        gl_Position.x += (gui_scale*182)/ScreenSize.x;
        vertexColor.rgb = vec3(1., 1., 1.);

        if (isShadow(Color, BG_RIGHT)) vertexColor.a = 0.;
    }

    if (isEither(Color, TRANSITION_IN)) {
        gl_Position.x = ((id >> 1) - 0.5) * 2;
        gl_Position.y = (((id+1) >> 1 & 1) - 0.5 ) * -2;
        gl_Position.z = -1.;

        transition = 1.;
        if (isShadow(Color, TRANSITION_IN)) vertexColor.a = 0.;
    }

    if (isEither(Color, TRANSITION_OUT)) {
        gl_Position.x = ((id >> 1) - 0.5) * 2;
        gl_Position.y = (((id+1) >> 1 & 1) - 0.5 ) * -2;
        gl_Position.z = -1.;

        transition = -1.;
        if (isShadow(Color, TRANSITION_OUT)) vertexColor.a = 0.;
    }

    // HAPPY GAY
    if (
        isEither(Color,HEALTH)
    ) {
        vertexColor.rgb = hsv2rgb(vec3(GameTimeSeconds*-0.2+gl_Position.x*2 + gl_Position.y, 0.85, 0.8));
    }
}