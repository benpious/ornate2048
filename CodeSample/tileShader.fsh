uniform sampler2D texture;
uniform sampler2D letterTexture;
uniform sampler2D backGroundTexture;
varying lowp vec3 fassetColor;
varying lowp vec2 ftexCoords;
varying lowp vec2 fblurTexCoords[7];

void main()
{
    
    lowp vec4 color = vec4(0.0);
    color += texture2D(texture, fblurTexCoords[0]) * 0.0044299121055113265;
    color += texture2D(texture, fblurTexCoords[1]) * 0.00895781211794;
    color += texture2D(texture, fblurTexCoords[2]) * 0.0215963866053;
    color += texture2D(texture, fblurTexCoords[3]) * 0.08873666774;
    color += texture2D(texture, fblurTexCoords[4]) * 0.155348844;
    color += texture2D(texture, fblurTexCoords[5]) * 0.2317532422;
    color += texture2D(texture, fblurTexCoords[6]) * 0.2946161122;
    
    lowp vec4 letterColor = texture2D(letterTexture, ftexCoords);
    lowp float alpha = texture2D(backGroundTexture, ftexCoords).a;
    gl_FragColor = vec4(vec3(color * vec4(fassetColor + .4, 1.0) + letterColor), alpha);
}