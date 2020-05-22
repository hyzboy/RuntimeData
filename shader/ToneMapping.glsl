/*

This shader experiments the effect of different tone mapping operators.
This is still a work in progress.

More info:
http://slideshare.net/ozlael/hable-john-uncharted2-hdr-lighting
http://filmicgames.com/archives/75
http://filmicgames.com/archives/183
http://filmicgames.com/archives/190
http://imdoingitwrong.wordpress.com/2010/08/19/why-reinhard-desaturates-my-blacks-3/
http://mynameismjp.wordpress.com/2010/04/30/a-closer-look-at-tone-mapping/
http://renderwonk.com/publications/s2010-color-course/

--
Zavie

*/

uniform float u_Exposure;


vec3 toneMap(vec3 color)
{
    color *= u_Exposure;

#ifdef TONEMAP_UNCHARTED
    return toneMapUncharted(color);
#endif

#ifdef TONEMAP_HEJLRICHARD
    return toneMapHejlRichard(color);
#endif

#ifdef TONEMAP_ACES
    return toneMapACES(color);
#endif

#ifdef TONEMAP_LINEAR
    return linearToneMapping(color);
#endif//TONEMAP_LINEAR

#ifdef TONEMAP_SIMPLE_REINHARD
    return simpleReinhardToneMapping(color)
#endif//TONEMAP_SIMPLE_REINHARD

#ifdef TONEMAP_LUMA_BASED_REINHARD
    return lumaBasedReinhardToneMapping(color)
#endif//TONE_MAP_LUMA_BASED_REINHARD

#ifdef TONEMAP_WHITE_PRESERVING_LUMA_BASED_REINHARD
    return whitePreservingLumaBasedReinhardToneMapping(color)
#endif//TONEMAP_WHITE_PRESERVING_LUMA_BASED_REINHARD

#ifdef TONEMAP_ROM_BIN_DA_HOUSE
    return RomBinDaHouseToneMapping(color)
#endif//TONEMAP_ROM_BIN_DA_HOUSE

    return linearTosRGB(color);
}
