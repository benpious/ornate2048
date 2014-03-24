uniform sampler2D texture;
varying mediump vec3 fvertPos;
varying lowp vec3 fassetColor;

void main()
{
    mediump vec2 mutableVertPos = vec2(fvertPos);
    mediump vec4 color = vec4(0.0);
    mediump float stepSize = 0.01;
    color += texture2D(texture, mutableVertPos) * 0.1621;
    color += texture2D(texture, mutableVertPos + stepSize) * 0.0983;
    color += texture2D(texture, mutableVertPos + stepSize * 2.0) * 0.0219;
    color += texture2D(texture, mutableVertPos + stepSize * 3.0) * 0.0030;
    color += texture2D(texture, mutableVertPos - stepSize) * 0.0596;
    color += texture2D(texture, mutableVertPos - stepSize * 2.0) * 0.0133;
    color += texture2D(texture, mutableVertPos - stepSize * 3.0) * 0.003;
    
    gl_FragColor = color * vec4(fassetColor, 1.0);
}
