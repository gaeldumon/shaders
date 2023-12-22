#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 sand = vec3(0.8471, 0.7765, 0.5608);
vec3 water = vec3(0.1216, 0.3725, 0.9137);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    vec3 pct = vec3(st.y);
    
    pct.r = st.x * st.y * 4.0;
    pct.g = st.x * st.y;
    pct.b = st.x * st.y * 6.0;
    
    vec3 color = mix(sand, water, pct);
    
    gl_FragColor = vec4(color, 1.0);
}