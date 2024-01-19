#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float checkerboard(vec2 uv) {
    return (sin(uv.x * PI * 10.0) / sin(uv.y * PI * 10.0)) * 100.0;
}

void main() {
    // Normalized fragment coordinates
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;
    
    // Goes around the surface following borders
    vec2 effectCenter = vec2(sin((u_time * 0.35)), cos((u_time * 0.35)));
    
    float effectRadius = 0.4;
    
    float effectStrength = 0.2;
    
    float distance = length(uv - effectCenter);
    
    float distortion = 1.0 + (effectStrength * (effectRadius - distance));
    
    vec2 distortedUV = effectCenter + (uv - effectCenter) * distortion;
    
    gl_FragColor = vec4(vec3(checkerboard(distortedUV)), 1.0);
}