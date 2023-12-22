#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

/*
* Blunt blink effect no smooth "transition" between the 2 values.
* We have -1 and 1 alternatively.
*/
float blink(float t, float freq) {
    return sign(sin(t * freq));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 finalColor = vec3(0.0);
    float pct = 0.0;
    
    // Black and red (anger emotion)
    vec3 colorA = vec3(0.0, 0.0, 0.0);
    vec3 colorB = vec3(0.7, 0.1, 0.1);
    
    // Blue and light green (calming down)
    vec3 colorC = vec3(0.149, 0.3804, 0.9647);
    vec3 colorD = vec3(0.0902, 1.0, 0.6353);
    
    if (sin(u_time) + 0.7 < 0.0) {
        // Blinking (anger)
        pct = blink(u_time, 25.0);
        finalColor = mix(colorA, colorB, pct);
    } else {
        // Smooth from blue to green (calming down)
        pct = sin(u_time / 2.0);
        finalColor = mix(colorC, colorD, pct);
    }
    
    gl_FragColor = vec4(finalColor, 1.0);
}