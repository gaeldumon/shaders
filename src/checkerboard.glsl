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
    
    vec2 effectCenter = vec2(sin((u_time * 0.5)), cos((u_time * 0.5)));
    
    // sin(time) oscillates between -1 and 1. By adding 1 to it, we make it oscillate between 0 and 2.
    // Multiplying by 0.1 scales the oscillation to be between 0 and 0.2.
    // Adding 0.2 shifts the oscillation to be between 0.2 and 0.4.
    float effectRadius = 0.2 + 2.0 * (1.0 + sin(u_time * 0.5));
    
    float effectStrength = 1.5;
    
    float distance = length(uv - effectCenter);
    
    float distortion = 1.0 + (effectStrength * (effectRadius - distance));
    vec2 distortedUV = effectCenter + (uv - effectCenter) * distortion;
    
    gl_FragColor = vec4(vec3(checkerboard(distortedUV)), 1.0);
}