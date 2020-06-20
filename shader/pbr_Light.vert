#version 450

layout(location = 0) in vec3 Vertex;
layout(location = 1) in vec3 Normal;

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

layout(push_constant) uniform Consts {
    mat4 local_to_world;
}pc;

layout(location=0) out vec3 FragmentWorldPos;
layout(location=1) out vec3 FragmentWorldNormal;

void main()
{
	FragmentWorldPos = Vertex*mat3(pc.local_to_world);
	FragmentWorldNormal = Normal*mat3(pc.local_to_world);

	gl_Position =  vec4(FragmentWorldPos,1.0)*world.mvp;
}
