#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PIH 1.57079632679
#define PI180 565.486677646

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// #######################################
// # Shaping functions from Inigo Quilez #
// #    https://www.iquilezles.org       #
// #######################################

float impulse(float k, float x) {
    float h = k*x;
    return h * exp(1.0 - h);
}

float expImpulse(float x, float k) {
    float h = k*x;
    return h * exp(1.0 - h);
}

float parabola(float x, float k) {
    return pow(4.0 * x*(1.0 - x), k);
}

float cubicPulse(float c, float w, float x) {
    x = abs(x - c);
    if (x > w)return 0.0;
    x /= w;
    return 1.0 - x*x * (3.0 - 2.0 * x);
}

float almostIdentity(float x, float m, float n) {
    if (x > m)return x;
    float a = 2.0 * n-m;
    float b = 2.0 * m-3.0 * n;
    float t = x / m;
    return (a * t+b) * t*t + n;
}

float almostUnitIdentity(float x) {
    return x * x*(2.0 - x);
}

// #########################################
// # Shaping functions with Kynd equations #
// #########################################

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

// ######################################################
// # Shaping functions from Flong Archive (Golan Levin) #
// # flong.com/archive/texts/code/shapers_poly          #
// ######################################################

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

// #######################
// # Utilitary functions #
// #######################

// Trace a line.
// Returns the difference between 2 smoothstep calls.
float plot(vec2 st, float y) {
    // The smoothstep function perform smooth Hermite
    // interpolation between two values:
    // 1st arg specifies the value of the lower edge of the
    // Hermite function.
    // 2nd arg specifies the value of the upper edge of the
    // Hermite function.
    // 3nd arg specifies the source value for
    // interpolation (here it's st.y).
    float w = 0.009;
    return smoothstep(y - w, y, st.y) - smoothstep(y, y + w, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    float y;
    // y = sin(st.x);
    // y = cos(st.x);
    // y = sin(u_time + st.x);
    // y = sin(u_time * st.x);
    // y = sin(st.x * PI);
    // y = sin(st.x * PIH);
    // y = sin(st.x * PI180);
    // y = sin(st.x) * 2.0;
    // y = abs(sin(st.x));
    // y = fract(sin(st.x));
    // y = ceil(sin(st.x));
    // y = floor(sin(st.x));
    
    y = step(0.5, st.x);
    // y = mod(st.x, 0.5); // return x modulo of 0.5
    // y = fract(st.x); // return only the fraction part of a number
    // y = ceil(st.x); // nearest integer that is greater than or equal to x
    // y = floor(st.x); // nearest integer less than or equal to x
    // y = sign(st.x); // extract the sign of x
    // y = abs(st.x); // return the absolute value of x
    // y = clamp(st.x, 0.0, 1.0); // constrain x to lie between 0.0 and 1.0
    // y = min(0.0, st.x); // return the lesser of x and 0.0
    // y = max(0.0, st.x); // return the greater of x and 0.0
    
    // Shaping with Inigo functions
    // y = impulse(12.0, st.x);
    // y = almostIdentity(st.x, 0.4, 0.0);
    // y = almostUnitIdentity(st.x);
    // y = expImpulse(st.x, 10.0);
    // y = cubicPulse(0.5, 0.2, st.x);
    // y = parabola(st.x, 1.0);
    
    // Shaping with kynd functions
    // y = kynd1(st.x, 0.5);
    // y = kynd2(st.x, 3.5);
    // y = kynd3(st.x, 2.5);
    // y = kynd4(st.x, 0.5);
    //y = kynd5(st.x, 1.0);
    
    float pct = plot(st, y);
    
    vec3 bg = vec3(y);
    
    vec3 linecolor = vec3(0.0, 1.0, 0.0);
    
    vec3 finalcolor = ((1.0 - pct) * bg) + (pct * linecolor);
    
    gl_FragColor = vec4(finalcolor, 1.0);
}