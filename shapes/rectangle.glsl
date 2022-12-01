#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 rectangle(vec2 coords, vec2 size, vec2 st) {
    if (
        st.x > (coords.x + (size.x / 2.0))||
        st.x < (coords.x - (size.x / 2.0))||
        st.y > (coords.y + (size.y / 2.0))||
        st.y < (coords.y - (size.y / 2.0))
    ) {
        return vec3(0.0);
    } else {
        return vec3(1.0);
    }
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);
    
    vec3 rect = rectangle(vec2(0.5, abs(sin(u_time))), vec2(0.3, 0.1), st);
    
    gl_FragColor = vec4(color + rect, 1.0);
}