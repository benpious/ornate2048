attribute vec4 position;
attribute vec3 assetColor;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 noMat;
uniform sampler2D texture;
varying vec4 fvertPos;
varying vec3 fassetColor;

void main()
{
    
    fvertPos = position;
    fassetColor = assetColor;
    
    gl_Position =  modelViewProjectionMatrix * position;
}