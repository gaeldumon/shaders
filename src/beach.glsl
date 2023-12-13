#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 colorA = vec3(0.8471, 0.7765, 0.5608);
vec3 colorB = vec3(0.1216, 0.3725, 0.9137);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    vec3 pct = vec3(st.y);
    
    pct.r = st.y * 4.0;
    pct.g = st.y;
    pct.b = st.y * 3.8;
    
    vec3 color = mix(colorA, colorB, pct);
    
    gl_FragColor = vec4(color, 1.0);
}