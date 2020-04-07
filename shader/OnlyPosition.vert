#version 450 core

layout(location = 0) in vec2 Vertex;

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

void main()
{
    gl_Position=vec4(Vertex,0.0,1.0)*world.ortho;
}
