attribute vec4 position;
attribute vec2 texCoord;
attribute vec3 assetColor;
uniform mat4 modelViewProjectionMatrix;
uniform sampler2D texture;
uniform sampler2D letterTexture;
uniform sampler2D backGroundTexture;
varying vec3 fassetColor;
varying vec2 ftexCoords;
varying vec2 fblurTexCoords[7];

void main()
{

    vec3 normalizedPos = (position.xyz + 1.0 )/2.0;
    fblurTexCoords[0] = vec2(normalizedPos) + vec2(0.0, -0.028);
    fblurTexCoords[1] = vec2(normalizedPos) + vec2(0.0, -0.020);
    fblurTexCoords[2] = vec2(normalizedPos) + vec2(0.0, -0.012);
    fblurTexCoords[3] = vec2(normalizedPos) + vec2(0.0, -0.004);
    fblurTexCoords[4] = vec2(normalizedPos) + vec2(0.0, 0.008);
    fblurTexCoords[5] = vec2(normalizedPos) + vec2(0.0, 0.016);
    fblurTexCoords[6] = vec2(normalizedPos) + vec2(0.0, 0.024);

    ftexCoords = texCoord;
    fassetColor = assetColor;
    
    gl_Position =  modelViewProjectionMatrix * position;
}