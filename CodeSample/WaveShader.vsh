attribute vec3 position;
uniform vec2 wavePos;
uniform float waveAmplitude;
uniform float wavePeriod;
uniform mat4 modelViewProjectMatrix;

varying float colorValue;
highp float dist(vec2 a, vec2 b) {
    
    float xsum = a.x + b.x;
    float ysum = a.y + b.y;
    return sqrt(xsum*xsum + ysum*ysum);
}

void main() {
    
    vec3 newPosition = position;
    
    newPosition.z = 0.1 * ((wavePeriod - dist(position.xy, wavePos))/wavePeriod) * waveAmplitude;
    colorValue = newPosition.z;
    gl_Position = modelViewProjectMatrix * vec4(newPosition, 1.0);
}