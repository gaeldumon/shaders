/*******************************************************************/
/* This is part of my shader training with the wonderful book      */
/* https://thebookofshaders.com                                    */
/*******************************************************************/

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PIH 1.57079632679
#define PI180 565.486677646

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

/*******************************************************************/
/* Shaping functions from Inigo Quilez                             */
/* https://www.iquilezles.org/                                     */
/*******************************************************************/

float impulse(float k, float x) {
    float h = k * x;
    return h * exp(1.0 - h);
}

float expImpulse(float x, float k) {
    float h = k * x;
    return h * exp(1.0 - h);
}

float cubicPulse(float c, float w, float x) {
    x = abs(x - c);
    if (x > w) return 0.0;
    x /= w;
    return 1.0 - x * x * (3.0 - 2.0 * x);
}

float almostIdentity(float x, float m, float n) {
    if (x > m) return x;
    float a = 2.0 * n - m;
    float b = 2.0 * m - 3.0 * n;
    float t = x / m;
    return (a * t + b) * t * t + n;
}

float almostUnitIdentity(float x) {
    return x * x * (2.0 - x);
}

/*******************************************************************/


/*******************************************************************/
/* Utilitary functions                                             */
/*******************************************************************/

/**
 * Trace a line
 */
float plot(vec2 st, float y) {
    float w = 0.009;
    return smoothstep(y-w, y, st.y) - smoothstep(y, y+w, st.y);
}

/*******************************************************************/


void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    float y;
    //y = sin(st.x);
    //y = cos(st.x);
    //y = sin(u_time + st.x);
    //y = sin(u_time * st.x);
    y = sin(st.x * PI);
    //y = sin(st.x * PIH);
    //y = sin(st.x * PI180);
    //y = sin(st.x) * 2.0;
    //y = abs(sin(st.x));
    //y = fract(sin(st.x));
    //y = ceil(sin(st.x));
    //y = floor(sin(st.x));

    //y = mod(st.x, 0.5); // return x modulo of 0.5
    //y = fract(st.x); // return only the fraction part of a number
    //y = ceil(st.x); // nearest integer that is greater than or equal to x
    //y = floor(st.x); // nearest integer less than or equal to x
    //y = sign(st.x); // extract the sign of x
    //y = abs(st.x); // return the absolute value of x
    //y = clamp(st.x, 0.0, 1.0); // constrain x to lie between 0.0 and 1.0
    //y = min(0.0, st.x); // return the lesser of x and 0.0
    //y = max(0.0, st.x); // return the greater of x and 0.0

    //y = impulse(12.0, st.x);
    //y = almostIdentity(st.x, 0.4, 0.);
    //y = almostUnitIdentity(st.x);
    //y = expImpulse(st.x, 10.0);
    //y = cubicPulse(0.5, 0.2, st.x);
    
    float pct = plot(st, y);

    vec3 bg = vec3(y);

    vec3 linecolor = vec3(1.0, 0.0, 0.0);

    vec3 finalcolor = ((1.0 - pct) * bg) + (pct * linecolor);
    
    gl_FragColor = vec4(finalcolor, 1.0);
}