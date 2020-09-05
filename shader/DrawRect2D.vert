#version 450 core

layout(location = 0) in vec4 Position;
layout(location = 1) in vec4 TexCoord;

layout(binding=0) uniform WorldMatrix     // hgl/math/Math.h
{
    mat4 ortho;

    mat4 projection;
    mat4 inverse_projection;

    mat4 modelview;
    mat4 inverse_modelview;

    mat4 mvp;
    mat4 inverse_mvp;

    vec4 view_pos;
    vec2 canvas_resolution;
    vec2 viewport_resolution;
}world;

layout(location=0) out vec4 GeometryTexCoord;

void main()
{
    vec4 lt=vec4(Position.xy,vec2(0,1));
    vec4 rb=vec4(Position.zw,vec2(0,1));

    vec4 lt_fin=lt*world.ortho;
    vec4 rb_fin=rb*world.ortho;

    GeometryTexCoord=TexCoord;

    gl_Position=vec4(lt_fin.xy,rb_fin.xy);
}
