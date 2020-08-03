#version 450 core

layout(binding = 2) uniform sampler2D tex;

layout(location = 0) in vec2 FragmentTexCoord;
layout(location = 0) out vec4 FragColor;

layout(binding = 1) uniform ColorMaterial
{
    vec4 color;
} color_material;

void main()
{
    float lum=texture(tex,FragmentTexCoord).r;

    FragColor=vec4(color_material.color.rgb*lum,color_material.color.a);
}
