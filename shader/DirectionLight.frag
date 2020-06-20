#version 450 core

layout(location = 0) in vec3 FragmentNormal;
layout(location = 0) out vec4 FragColor;

layout(binding=10) uniform WorldMatrix     // hgl/math/Math.h
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
}fs_world;

layout(binding=1) uniform ColorMaterial
{
    vec4 color;
    vec4 ambient;
} color_material;


layout(binding=2) uniform Sun
{
    vec3 direction;
}sun;

vec4 ComputeSunlightFinalColor()
{
    float intensity=max(dot(normalize(FragmentNormal*mat3(fs_world.mvp)),sun.direction),0.0);

    return max(color_material.color*intensity,color_material.ambient);
}

void main()
{
    FragColor=ComputeSunlightFinalColor();
}
