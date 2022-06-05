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

uniform vec2 u_resolution;
uniform float u_time;

float blink(float t, float freq) {
    // No x here and we use sign() because we want
    // blunt blink effect, no smooth "transition" between
    // the 2 values. We have -1 and 1 alternatively.
    return sign(sin(t * freq));
}

void main() {
    // Black and red (anger emotion)
    vec3 colorA = vec3(0.0, 0.0, 0.0);
    vec3 colorB = vec3(0.7, 0.1, 0.1);
    
    // Nice blue and light green (calming down)
    vec3 colorC = vec3(0.149, 0.3804, 0.9647);
    vec3 colorD = vec3(0.0902, 1.0, 0.6353);
    
    vec3 finalColor = vec3(0.0);
    
    // Blinking (anger)
    float pct = blink(u_time, 14.0);
    // Smooth from blue to green (calming down)
    //float pct=clamp(u_time/10.,.0,1.);
    
    // Mix uses pct (a value from 0-1) to mix colors
    // I don't know how to do the blinking first and
    // when it reaches a certain value, do the smooth
    // transition between blue/green.
    finalColor = mix(colorA, colorB, pct);
    //finalColor=mix(colorC,colorD,pct);
    
    gl_FragColor = vec4(finalColor, 1.0);
}