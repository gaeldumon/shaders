#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    // Normalized fragment coordinates
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;
    
    float wavedUvSinFreq = 100.0;
    vec2 xyWavedUv = vec2(uv.x + sin(uv.y * wavedUvSinFreq) * 0.1, uv.y + sin(uv.x * wavedUvSinFreq) * 0.1);
    
    float stren = step(3.0, mod(xyWavedUv.x * 10.0, 6.0));
    stren -= step(3.0, mod(xyWavedUv.y * 10.0, 6.0));
    
    vec3 color1 = vec3(0.9059, 0.7137, 0.3216);
    vec3 color2 = vec3(0.6588, 0.0, 0.0);
    vec3 color3 = vec3(1.0, 0.5176, 0.0);
    
    vec3 uvColor = vec3(uv, 1.0);
    
    vec3 mixedColor = mix(color1, color2, stren);
    
    gl_FragColor = vec4(mixedColor, 1.0);
}