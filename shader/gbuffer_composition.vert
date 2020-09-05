#version 450 core

layout(location = 0) in vec2 Position;

layout(location = 0) out vec2 FragmentPosition;

void main()
{
    gl_Position=vec4(Position,0.0,1.0);

    FragmentPosition=(Position+1.0)/2.0;
}
