uniform sampler2D texture;
uniform sampler2D letterTexture;
uniform sampler2D backGroundTexture;
varying mediump vec3 fvertPos;
varying lowp vec3 fassetColor;
varying lowp vec2 ftexCoords;

void main()
{
    mediump vec2 mutableVertPos = vec2(fvertPos);
    mediump vec4 color = vec4(0.0);
    mediump float stepSize = 0.05;
    color += texture2D(texture, mutableVertPos) * 0.1021;
    color += texture2D(texture, mutableVertPos + stepSize) * 0.1083;
    color += texture2D(texture, mutableVertPos + stepSize * 2.0) * 0.0719;
    color += texture2D(texture, mutableVertPos + stepSize * 3.0) * 0.050;
    color += texture2D(texture, mutableVertPos - stepSize) * 0.0596;
    color += texture2D(texture, mutableVertPos - stepSize * 2.0) * 0.0233;
    color += texture2D(texture, mutableVertPos - stepSize * 3.0) * 0.04;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0983;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0619;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.04;
    mutableVertPos.x+= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.04;
    mutableVertPos.y-= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0983;
    mutableVertPos.y-= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.0619;
    mutableVertPos.y-= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.04;
    mutableVertPos.y-= stepSize;
    color += texture2D(texture, mutableVertPos) * 0.04;
    
    lowp vec4 letterColor = texture2D(letterTexture, ftexCoords);
    lowp vec4 shapeColor = texture2D(backGroundTexture, ftexCoords);
    gl_FragColor = (color * vec4(fassetColor + .4, 1.0) + letterColor) * shapeColor.w;
}
