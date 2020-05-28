vec2 EncodeNormal(vec3 _normal)
{
	return normalize(_normal.xy) * sqrt(_normal.z * 0.5 + 0.5);
}

vec3 DecodeNormal(vec2 _encodedNormal)
{
	float zz = dot(_encodedNormal, _encodedNormal) * 2.0 - 1.0;
	return vec3(normalize(_encodedNormal.xy) * sqrt(1.0 - zz*zz), zz);
}
