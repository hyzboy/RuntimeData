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

float Hex( vec2 p, vec2 h )
{
	vec2 q = abs(p);
    return max(q.x-h.y,max(q.x+q.y*0.57735,q.y*1.1547)-h.x);
}

float HexGrid(vec2 p)
{
    float scale = 1.2;
    vec2 grid = vec2(0.692, 0.4) * scale;
    float radius = 0.22 * scale;

    vec2 p1 = mod(p.xy, grid) - grid*0.5;
    float c1 = Hex(p1, vec2(radius, radius));

    vec2 p2 = mod(p.xy+grid*0.5, grid) - grid*0.5;
    float c2 = Hex(p2, vec2(radius, radius));
    return min(c1, c2);
}

void main()
{
    vec2 uv=(gl_FragCoord.xy-fs_world.canvas_resolution.xy/2.0)/80.0;

    float lum=HexGrid(uv);

    lum=lum > 0.0 ? 1.0 : 0.0;

    FragColor=vec4(color_material.color.rgb*lum,1.0);
}
