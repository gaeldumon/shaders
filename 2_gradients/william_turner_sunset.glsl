#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.2392, 0.3412, 0.9098);
vec3 colorB = vec3(1.0, 0.9333, 0.0039);

float plot(vec2 st, float pct) {
    return smoothstep(pct - 0.01, pct, st.y) -
    smoothstep(pct, pct + 0.01, st.y);
}

float doubleCubicSeatWithLinearBlend(float x, float a, float b) {
    float epsilon = 0.00001;
    float min_param_a = 0.0 + epsilon;
    float max_param_a = 1.0 - epsilon;
    float min_param_b = 0.0;
    float max_param_b = 1.0;
    
    a = min(max_param_a, max(min_param_a, a));
    b = min(max_param_b, max(min_param_b, b));
    
    // reverse for intelligibility
    b = 1.0 - b;
    
    float y = 0.0;
    
    if (x <= a) {
        y = b*x + (1.0 - b) * a*(1.0 - pow(1.0 - x / a, 3.0));
    } else {
        y = b*x + (1.0 - b) * (a + (1.0 - a) * pow((x - a) / (1.0 - a), 3.0));
    }
    
    return y;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);
    
    vec3 pct = vec3(st.x);
    
    // The lines visualize the amount of colorA and
    // colorB to mix per channel
    pct.r = smoothstep(0.0, 0.2, st.y);
    pct.g = doubleCubicSeatWithLinearBlend(st.y, 0.6, 0.8);
    pct.b = pow(st.y, 0.3);
    
    color = mix(colorA, colorB, pct);
    
    // Plot transition lines for each channel
    // color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, pct.r));
    // color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, pct.g));
    // color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, pct.b));
    
    gl_FragColor = vec4(color, 1.0);
}