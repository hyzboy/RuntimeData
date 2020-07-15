#version 450 core

layout(location=0) out vec4 FragColor;

layout(binding=1) uniform ColorMaterial
{
    vec4 color;
} color_material;

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

float bg_grid_texture(vec2 coord)
{
    vec2 index = ceil(coord * 0.1);

    return 0.7 + 0.5*mod(index.x + index.y, 2.0);
}

void main()
{
    float strong=bg_grid_texture(gl_FragCoord.xy);

    FragColor=vec4(color_material.color.rgb*strong,1.0);
}
