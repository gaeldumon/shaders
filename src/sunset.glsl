#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PIH 1.57079632679
#define PI180 565.486677646

uniform vec2 u_resolution;

vec3 colorA = vec3(0.8549019607843137, 0.4549019607843137, 0.13333333333333333);
vec3 colorB = vec3(0.18823529411764706, 0.3215686274509804, 0.34901960784313724);

float plot(vec2 st, float pct) {
    return smoothstep(pct - 0.01, pct, st.y) -
    smoothstep(pct, pct + 0.01, st.y);
}

float kynd1(float x, float expo) {
    return 1.0 - pow(abs(x), expo);
}

float kynd2(float x, float expo) {
    return pow(cos(PI * x / 2.0), expo);
}

float kynd3(float x, float expo) {
    return 1.0 - pow(abs(sin(PI * x / 2.0)), expo);
}

float kynd4(float x, float expo) {
    return pow(min(cos(PI * x / 2.0), 1.0 - abs(x)), expo);
}

float kynd5(float x, float expo) {
    return 1.0 - pow(max(0.0, abs(x) * 2.0 - 1.0), expo);
}

float parabola(float x, float k) {
    return pow(4.0 * x*(1.0 - x), k);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);
    
    vec3 pct = vec3(st.x);
    
    // The lines visualize the amount of colorA and
    // colorB to mix per channel
    // To see the plot transition lines, orientation = st.x
    float orientation = st.y;
    pct.r = smoothstep(0.0, 0.45, orientation);
    pct.g = 0.0;
    pct.b = pow(orientation, 0.3);
    
    color = mix(colorA, colorB, pct);
    
    // Plot transition lines for each channel
    //color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, pct.r));
    //color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, pct.g));
    //color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, pct.b));
    
    gl_FragColor = vec4(color, 1.0);
}