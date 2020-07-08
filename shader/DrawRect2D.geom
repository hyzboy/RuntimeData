#version 450 core

layout (points) in;
layout (triangle_strip,max_vertices=4) out;

layout(location=0) in vec4 GeometryTexCoord[];
layout(location=0) out vec2 FragmentTexCoord;

void main()
{
    vec2 vlt=gl_in[0].gl_Position.xy;
    vec2 vrb=gl_in[0].gl_Position.zw;
    vec2 tlt=GeometryTexCoord[0].xy;
    vec2 trb=GeometryTexCoord[0].zw;

    gl_Position=vec4(vlt,           vec2(0,1));FragmentTexCoord=tlt;                EmitVertex();
    gl_Position=vec4(vlt.x, vrb.y,  vec2(0,1));FragmentTexCoord=vec2(tlt.x,trb.y);  EmitVertex();
    gl_Position=vec4(vrb.x, vlt.y,  vec2(0,1));FragmentTexCoord=vec2(trb.x,tlt.y);  EmitVertex();
    gl_Position=vec4(vrb,           vec2(0,1));FragmentTexCoord=trb;                EmitVertex();

    EndPrimitive();
}
