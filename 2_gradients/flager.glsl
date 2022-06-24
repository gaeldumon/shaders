#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 color1 = vec3(0.1176, 0.1098, 0.6588);
vec3 color2 = vec3(0.6549, 0.0667, 0.0667);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    vec3 pct = vec3(step(0.7, st.x), 0.0, step(0.3, st.x));
    
    vec3 final = mix(color1, color2, pct);
    
    if (st.x >= 0.3 && st.x <= 0.7) {
        final = vec3(1.0);
    }
    
    gl_FragColor = vec4(final, 1.0);
}