uniform sampler2D texture;
varying vec4 fvertPos;
varying vec3 fassetColor;

void main()
{
    
    gl_FragColor = texture2D(uiTexture, vec2(fvertPos)) * fassetColor;
}
