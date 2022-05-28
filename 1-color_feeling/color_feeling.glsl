// Make an expressive transition between colors.
// Think of a particular emotion. What color seems most representative of it?
// How does it appear? How does it fade away?
// Think of another emotion and the matching color for it.
// Change the beginning and ending color of the above code to match those emotions.
// Then animate the transition using shaping functions.
// Robert Penner developed a series of popular shaping functions for computer animation
// known as easing functions, you can use this example as research and inspiration
// but the best result will come from making your own transitions.

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PIH 1.57079632679
#define PI180 565.486677646

uniform vec2 u_resolution;
uniform float u_time;

float impulse(float k,float x){
    float h=k*x;
    return h*exp(1.-h);
}

float kynd2(float x,float expo){
    return pow(cos(PI*x/2.),expo);
}

vec3 colorA=vec3(.3765,0.,.9882);
vec3 colorB=vec3(.8745,1.,.3059);

void main(){
    vec3 color=vec3(0.);
    
    float pct=abs(sin(u_time));
    
    // Mix uses pct (a value from 0-1) to mix the two colors
    color=mix(colorA,colorB,pct);
    
    gl_FragColor=vec4(color,1.);
}