#version 450 core

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

layout(binding=1) uniform ColorMaterial
{
    vec4 color;
    vec4 amibent;
} color_material;

layout(binding=2) uniform Sun
{
    vec3 direction;
}sun;

layout(location=0) out vec4 FragmentColor;

float GetSunlightIntensity()
{
    return max(dot(normalize(Normal*mat3(world.mvp)),sun.direction),0.0);
}

void main()
{
    FragmentColor=color_material.color*GetSunlightIntensity()+color_material.amibent;

    gl_Position=vec4(Vertex,1.0)*(pc.local_to_world*world.mvp);
}
