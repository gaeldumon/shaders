#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    
    float strength = 0.0;
    
    strength = step(0.18, max(abs(uv.x - 0.5), abs(uv.y - 0.5)));
    strength *= step(0.1, max(abs(uv.x - 0.15), abs(uv.y - 0.5)));
    strength *= step(0.1, max(abs(uv.x - 0.85), abs(uv.y - 0.5)));
    strength *= step(0.1, max(abs(uv.x - 0.5), abs(uv.y - 0.15)));
    strength *= step(0.1, max(abs(uv.x - 0.5), abs(uv.y - 0.85)));
    
    gl_FragColor = vec4(vec3(strength), 1.0);
}