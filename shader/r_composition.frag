#version 460 core
/**
 * Copyright (c) 2018-2020 www.hyzgame.com
 *
 * Create by ShaderMaker
 */
layout(push_constant) uniform Consts
{
    mat4 local_to_world;
    mat3 normal;
    vec3 object_position;
    vec3 object_size;
} pc;
layout(binding = 0) uniform WorldMatrix     // hgl/math/Math.h
{
    mat4 ortho;

    mat4 projection;
    mat4 inverse_projection;

    mat4 modelview;
    mat4 inverse_modelview;

    mat4 mvp;
    mat4 inverse_mvp;

    vec4 view_pos;
} world;

layout(binding=0) uniform sampler2D rb_depth;
layout(binding=1) uniform sampler2D gb_color_metallic;
layout(binding=2) uniform sampler2D gb_normal_roughness;

layout(location=0) in vec2 vs_out_position;
layout(location=0) out vec4 FragColor;

void main()
{
    vec3 BaseColor;
    vec3 Normal;
    float Metallic;
    float Roughness;

    vec4 gb_cm=texture(gb_color_metallic,FragmentPosition);
    vec4 gb_cr=texture(gb_normal_roughness,FragmentPosition);
    BaseColor =gb_cm.rgb;
    Metallic  =gb_cm.a;
    Normal    =gb_cr.rgb;
    Roughness =gb_cr.a;

//[Begin] Your code------------------------------------

//[End] Your code--------------------------------------
    FragColor=
}
