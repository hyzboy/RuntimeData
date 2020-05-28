/*
 * Copyright 2011-2019 Branimir Karadzic. All rights reserved.
 * License: https://github.com/bkaradzic/bgfx#license-bsd-2-clause
 */

vec4 encodeRE8(float _r)
{
	float exponent = ceil(log2(_r) );
	return vec4(_r / exp2(exponent)
		, 0.0
		, 0.0
		, (exponent + 128.0) / 255.0
		);
}

float decodeRE8(vec4 _re8)
{
	float exponent = _re8.w * 255.0 - 128.0;
	return _re8.x * exp2(exponent);
}

vec4 encodeRGBE8(vec3 _rgb)
{
	vec4 rgbe8;
	float maxComponent = max(max(_rgb.x, _rgb.y), _rgb.z);
	float exponent = ceil(log2(maxComponent) );
	rgbe8.xyz = _rgb / exp2(exponent);
	rgbe8.w = (exponent + 128.0) / 255.0;
	return rgbe8;
}

vec3 decodeRGBE8(vec4 _rgbe8)
{
	float exponent = _rgbe8.w * 255.0 - 128.0;
	vec3 rgb = _rgbe8.xyz * exp2(exponent);
	return rgb;
}

vec3 encodeNormalUint(vec3 _normal)
{
	return _normal * 0.5 + 0.5;
}

vec3 decodeNormalUint(vec3 _encodedNormal)
{
	return _encodedNormal * 2.0 - 1.0;
}



vec3 toReinhard(vec3 _rgb)
{
	return toGamma(_rgb/(_rgb+vec3_splat(1.0) ) );
}

vec4 toReinhard(vec4 _rgba)
{
	return vec4(toReinhard(_rgba.xyz), _rgba.w);
}

vec3 toFilmic(vec3 _rgb)
{
	_rgb = max(vec3_splat(0.0), _rgb - 0.004);
	_rgb = (_rgb*(6.2*_rgb + 0.5) ) / (_rgb*(6.2*_rgb + 1.7) + 0.06);
	return _rgb;
}

vec4 toFilmic(vec4 _rgba)
{
	return vec4(toFilmic(_rgba.xyz), _rgba.w);
}

vec3 toAcesFilmic(vec3 _rgb)
{
	// Reference(s):
	// - ACES Filmic Tone Mapping Curve
	//   https://web.archive.org/web/20191027010704/https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
	float aa = 2.51f;
	float bb = 0.03f;
	float cc = 2.43f;
	float dd = 0.59f;
	float ee = 0.14f;
	return saturate( (_rgb*(aa*_rgb + bb) )/(_rgb*(cc*_rgb + dd) + ee) );
}

vec4 toAcesFilmic(vec4 _rgba)
{
	return vec4(toAcesFilmic(_rgba.xyz), _rgba.w);
}

vec3 blendOverlay(vec3 _base, vec3 _blend)
{
	vec3 lt = 2.0 * _base * _blend;
	vec3 gte = 1.0 - 2.0 * (1.0 - _base) * (1.0 - _blend);
	return mix(lt, gte, step(vec3_splat(0.5), _base) );
}

vec4 blendOverlay(vec4 _base, vec4 _blend)
{
	return vec4(blendOverlay(_base.xyz, _blend.xyz), _base.w);
}



vec3 fixCubeLookup(vec3 _v, float _lod, float _topLevelCubeSize)
{
	// Reference(s):
	// - Seamless cube-map filtering
	//   https://web.archive.org/web/20190411181934/http://the-witness.net/news/2012/02/seamless-cube-map-filtering/
	float ax = abs(_v.x);
	float ay = abs(_v.y);
	float az = abs(_v.z);
	float vmax = max(max(ax, ay), az);
	float scale = 1.0 - exp2(_lod) / _topLevelCubeSize;
	if (ax != vmax) { _v.x *= scale; }
	if (ay != vmax) { _v.y *= scale; }
	if (az != vmax) { _v.z *= scale; }
	return _v;
}

vec2 texture2DBc5(sampler2D _sampler, vec2 _uv)
{
#if BGFX_SHADER_LANGUAGE_HLSL && BGFX_SHADER_LANGUAGE_HLSL <= 3
	return texture2D(_sampler, _uv).yx;
#else
	return texture2D(_sampler, _uv).xy;
#endif
}

mat3 cofactor(mat4 _m)
{
	// Reference:
	// Cofactor of matrix. Use to transform normals. The code assumes the last column of _m is [0,0,0,1].
	// https://www.shadertoy.com/view/3s33zj
	// https://github.com/graphitemaster/normals_revisited
	return mat3(
		_m[1][1]*_m[2][2]-_m[1][2]*_m[2][1],
		_m[1][2]*_m[2][0]-_m[1][0]*_m[2][2],
		_m[1][0]*_m[2][1]-_m[1][1]*_m[2][0],
		_m[0][2]*_m[2][1]-_m[0][1]*_m[2][2],
		_m[0][0]*_m[2][2]-_m[0][2]*_m[2][0],
		_m[0][1]*_m[2][0]-_m[0][0]*_m[2][1],
		_m[0][1]*_m[1][2]-_m[0][2]*_m[1][1],
		_m[0][2]*_m[1][0]-_m[0][0]*_m[1][2],
		_m[0][0]*_m[1][1]-_m[0][1]*_m[1][0]
		);
}
