#version 450 core

layout(location = 0) in vec3 Position;
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
    vec4 ambient;
} color_material;

layout(binding=2) uniform Sun
{
    vec3 direction;
}sun;

layout(location=0) out vec4 FragmentColor;

vec4 ComputeSunlightFinalColor(vec4 color,vec4 ambient)
{
    float intensity=max(dot(normalize(Normal*mat3(world.mvp)),sun.direction),0.0);

    return max(color*intensity,ambient);
}

void main()
{
    FragmentColor=ComputeSunlightFinalColor(color_material.color,color_material.ambient);

    gl_Position=vec4(Position,1.0)*(pc.local_to_world*world.mvp);
}
