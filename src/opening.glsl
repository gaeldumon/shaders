#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float parabola(float x, float k) {
    return pow(4.0 * x * (1.0 - x), k);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    float y = parabola(st.x, 50.0) * 2.0 * abs(sin(u_time / 2.0));
    vec3 bg = vec3(y);
    gl_FragColor = vec4(bg, 1.0);
}