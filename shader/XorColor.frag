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

void main()
{
    vec2 p = 256.0 * gl_FragCoord.xy/fs_world.canvas_resolution.x;

    float x = 0.0;

    for( int i=0; i<7; i++ )
    {
        vec2 a = floor(p);
        vec2 b = fract(p);

        x += mod( a.x + a.y, 2.0 ) *

            // the following line implements the smooth xor
            mix( 1.0, 1.5*pow(4.0*(1.0-b.x)*b.x*(1.0-b.y)*b.y,0.25), 0.0 );

        p /= 2.0;
        x /= 2.0;
    }

    FragColor=vec4(color_material.color.rgb*x,1.0);
}
