#version 450 core

layout(location = 0) in vec3 Position;
layout(location = 1) in vec2 TexCoord;
layout(location = 2) in vec3 Normal;
layout(location = 3) in vec3 Tangent;

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
    vec2 resolution;
} world;

layout(push_constant) uniform Consts {
    mat4 local_to_world;
} pc;

layout(location = 0) out struct
{
    vec3 Normal;
    vec3 Tangent;
    vec3 Position;
    vec2 TexCoord;
}vs_out;

void main()
{
    vec4 pos=vec4(Position,1.0)*pc.local_to_world;

    gl_Position=pos*world.mvp;

    vs_out.Position=(pos*world.modelview).xyz;
    vs_out.TexCoord=TexCoord;

    mat3 n=mat3(pc.local_to_world*world.modelview);

    vs_out.Normal=normalize(Normal)*n;
    vs_out.Tangent=normalize(Tangent)*n;
}
