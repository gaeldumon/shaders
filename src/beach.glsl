#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PIH 1.57079632679
#define PI180 565.486677646

uniform vec2 u_resolution;

float plot(vec2 st, float pct) {
    return smoothstep(pct - 0.01, pct, st.y) -
    smoothstep(pct, pct + 0.01, st.y);
}

vec3 colorA = vec3(0.898, 0.5569, 0.0784);
vec3 colorB = vec3(0.03529411764705882, 0.5529411764705883, 0.6039215686274509);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);
    
    vec3 pct = vec3(st.x);
    
    // The lines visualize the amount of colorA and
    // colorB to mix per channel
    // To see the plot transition lines, orientation = st.x
    float orientation = st.y;
    pct.r = smoothstep(0.15, 0.55, orientation);
    pct.g = 0.0;
    pct.b = 1.0;
    
    color = mix(colorA, colorB, pct);
    
    // Plot transition lines for each channel
    //color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, pct.r));
    //color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, pct.g));
    //color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, pct.b));
    
    gl_FragColor = vec4(color, 1.0);
}