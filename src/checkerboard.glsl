#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 effectCenter = (u_mouse.xy * 2.0 - u_resolution) / u_resolution.y;
float effectRadius = 0.3;
float effectStrength = 1.5;

float checkerboard(vec2 uv) {
    return (sin(uv.x * PI * 10.0) / sin(uv.y * PI * 10.0)) * 100.0;
}

void main() {
    // Normalized fragment coordinates
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;
    
    vec3 final = vec3(0.0);
    
    float distance = length(uv - effectCenter);
    
    if (distance < effectRadius) {
        float distortion = 1.0 + (effectStrength * (effectRadius - distance));
        vec2 distortedUV = effectCenter + (uv - effectCenter) * distortion;
        final = vec3(checkerboard(distortedUV));
    } else {
        final = vec3(checkerboard(uv));
    }
    
    gl_FragColor = vec4(final, 1.0);
}