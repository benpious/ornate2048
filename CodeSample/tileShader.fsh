uniform sampler2D texture;
varying mediump vec3 fvertPos;
varying lowp vec3 fassetColor;

void main()
{
    mediump vec2 mutableVertPos = vec2(fvertPos);
    mediump vec4 color = vec4(0.0);
    mediump float stepSize = 0.01;
    color += texture2D(texture, mutableVertPos) * 0.1021;
    color += texture2D(texture, mutableVertPos + stepSize) * 0.1083;
    color += texture2D(texture, mutableVertPos + stepSize * 2.0) * 0.0519;
    color += texture2D(texture, mutableVertPos + stepSize * 3.0) * 0.030;
    color += texture2D(texture, mutableVertPos - stepSize) * 0.0596;
    color += texture2D(texture, mutableVertPos - stepSize * 2.0) * 0.0233;
    color += texture2D(texture, mutableVertPos - stepSize * 3.0) * 0.03;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0983;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0219;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.003;
    
    gl_FragColor = color * vec4(fassetColor + .4, 1.0);
}
