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

const float TAU = 2.* 3.1415926535897932384626433832795;
const float grid4 = 2097152.0,grid3 = 131072.0,grid2 = 1024.0,grid1 = 64.0;

float grid(vec2 f, vec3 pos, float rdy, float t) {
    float ff = min(fs_world.canvas_resolution.x,fs_world.canvas_resolution.y)/1024.0;
	vec4 distances = (abs(pos.xz)* TAU).xxyy;
	float referenceBase = log(20.*ff/ (t* pow(abs(rdy),.8)))/ log(10.);
	float nearestBase = floor(referenceBase);
	float partialBase = fract(referenceBase);
	const vec4 gain = vec4(grid4- grid3,grid1,grid3- grid2,grid2- grid1);
	const vec4 off = vec4(grid3,0,grid2,grid1);
	vec4 exponentialBase = partialBase* partialBase* gain+ off;
	vec4 bases = pow(vec4(10),nearestBase+ vec4(-2,1,-1,0));
	vec4 lx = pow(.5+ .5* cos(distances* bases.xyxy),exponentialBase.xyxy);
	vec4 ly = pow(.5+ .5* cos(distances* bases.zwzw),exponentialBase.zwzw);
	vec4 l4 = (1.- lx* vec4(1.- partialBase,partialBase,1.- partialBase,partialBase))* (1.- ly);
	vec2 l2 = l4.xy* l4.zw;
	float l1 = .30078125* (1.- l2.x* l2.y);
	return l1;
}

float EndlessGird(vec2 f)
{
	float rcpResY = 1./ fs_world.canvas_resolution.y;
	vec2 uv = 2.0* rcpResY* f- vec2(fs_world.canvas_resolution.x* rcpResY,1);
	vec3 ro = vec3(0,1.0,0);
	vec3 rd = normalize(vec3(uv.x,-1,uv.y));
	float t = 1.0/ -rd.y;
	vec3 pos = ro + t* rd;
	return grid(f,pos,rd.y,t);
}

void main()
{
    float strong=EndlessGird(gl_FragCoord.xy);

    FragColor=vec4(color_material.color.rgb*strong,1.0);
}
