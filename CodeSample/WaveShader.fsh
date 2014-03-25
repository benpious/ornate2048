varying lowp float colorValue;
varying lowp vec2 texCoords;

uniform sampler2D backgroundTexture;

void main(void)
{
    
    gl_FragColor = texture2D(backgroundTexture, texCoords);
}
