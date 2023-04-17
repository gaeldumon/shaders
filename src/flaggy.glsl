#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 color1 = vec3(0.780, 0.125, 0.987);
vec3 color2 = vec3(0.145, 0.987, 0.025);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    vec3 pct = vec3(0.0);
    pct.r = step(0.33, st.x);
    pct.g = step(0.66, st.x);
    pct.b = step(0.5, st.y);
    
    vec3 final = mix(color1, color2, pct);
    gl_FragColor = vec4(final, 1.0);
}