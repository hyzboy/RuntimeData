#version 460 core
/**
 * Copyright (c) 2018-2020 www.hyzgame.com
 *
 * Create by ShaderMaker
 */

layout(location = 0) in vec2 Vertex;

layout(location = 0) out vec2 vs_out_position;

void main()
{
    gl_Position=vec4(Vertex,0.0,1.0);

    vs_out_position=(Vertex+1.0)/2.0;
}
