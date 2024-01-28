#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 sand = vec3(0.8471, 0.7765, 0.5608);
vec3 water = vec3(0.1216, 0.3725, 0.9137);

float waving() {
    float wave = sin(u_time * 0.6) * 0.35 + 0.5;
    return wave;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    vec3 pct = vec3(st.y);
    
    // Red channel
    pct.r = st.x * st.y * 4.0 * waving();
    // Green channel
    pct.g = st.x * st.y * waving();
    // Blue channel
    pct.b = st.x * st.y * 6.0 * waving();
    
    vec3 color = mix(sand, water, pct);
    
    gl_FragColor = vec4(color, 1.0);
}