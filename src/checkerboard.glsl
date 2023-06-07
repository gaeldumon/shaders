#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;

float checkerboard(vec2 uv) {
    return (sin(uv.x * PI * 10.0) / sin(uv.y * PI * 10.0)) * 10.0;
}

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;
    vec3 final = vec3(checkerboard(uv));
    gl_FragColor = vec4(final, 1.0);
}