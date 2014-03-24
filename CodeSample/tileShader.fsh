uniform sampler2D texture;
varying lowp vec3 fvertPos;
varying lowp vec3 fassetColor;

void main()
{
    
    gl_FragColor = texture2D(texture, vec2(fvertPos)) * vec4(fassetColor, 1.0);
}
