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

layout(location=0) out vec4 gb_color_metallic;
layout(location=1) out vec4 gb_normal_roughness;

void main()
{
    vec3 BaseColor;
    vec3 Normal;
    float Metallic;
    float Roughness;
//[Begin] Your code------------------------------------

//[End] Your code--------------------------------------
    gb_color_metallic   =vec4(BaseColor,Metallic);
    gb_normal_roughness =vec4(Normal,   Roughness);
}
