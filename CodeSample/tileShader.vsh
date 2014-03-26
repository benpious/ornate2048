attribute vec4 position;
attribute vec2 texCoord;
attribute vec3 assetColor;
uniform mat4 modelViewProjectionMatrix;
uniform sampler2D texture;
uniform sampler2D letterTexture;
uniform sampler2D backGroundTexture;
varying vec3 fvertPos;
varying vec3 fassetColor;
varying vec2 ftexCoords;

void main()
{

    ftexCoords = texCoord;
    fvertPos = (position.xyz + 1.0 )/2.0;
    fassetColor = assetColor;
    
    gl_Position =  modelViewProjectionMatrix * position;
}