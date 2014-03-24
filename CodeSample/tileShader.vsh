attribute vec4 position;
attribute vec3 assetColor;
uniform mat4 modelViewProjectionMatrix;
uniform sampler2D texture;
varying vec3 fvertPos;
varying vec3 fassetColor;

void main()
{
    
    fvertPos = vec3(position);
    fassetColor = assetColor;
    
    gl_Position =  modelViewProjectionMatrix * position;
}