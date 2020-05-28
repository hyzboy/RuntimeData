vec3 luma(vec3 _rgb)
{
	float yy = dot(vec3(0.2126729, 0.7151522, 0.0721750), _rgb);
	return vec3(yy,yy,yy);
}

vec4 luma(vec4 _rgba)
{
	return vec4(luma(_rgba.xyz), _rgba.w);
}

vec3 conSatBri(vec3 _rgb, vec3 _csb)
{
	vec3 rgb = _rgb * _csb.z;
	rgb = mix(luma(rgb), rgb, _csb.y);
	rgb = mix(vec3(0.5,0.5,0.5), rgb, _csb.x);
	return rgb;
}

vec4 conSatBri(vec4 _rgba, vec3 _csb)
{
	return vec4(conSatBri(_rgba.xyz, _csb), _rgba.w);
}

vec3 posterize(vec3 _rgb, float _numColors)
{
	return floor(_rgb*_numColors) / _numColors;
}

vec4 posterize(vec4 _rgba, float _numColors)
{
	return vec4(posterize(_rgba.xyz, _numColors), _rgba.w);
}

vec3 sepia(vec3 _rgb)
{
	vec3 color;
	color.x = dot(_rgb, vec3(0.393, 0.769, 0.189) );
	color.y = dot(_rgb, vec3(0.349, 0.686, 0.168) );
	color.z = dot(_rgb, vec3(0.272, 0.534, 0.131) );
	return color;
}

vec4 sepia(vec4 _rgba)
{
	return vec4(sepia(_rgba.xyz), _rgba.w);
}
