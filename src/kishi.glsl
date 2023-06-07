#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.0, 0.33, 0.66);
    
    return a + b * cos(6.28318 * (c * t + d));
}

// The whole game is to map the 2D coordinate of a pixel to an output color.
// The work is done in parrallel for all pixels.
void main() {
    // FragCoord is the coordinate of the current PIXEL (not all pixels but
    // just the current one the program is working on), we normalize it to clip
    // space (0.0 to 1.0) to facilitate work/calculations.
    vec2 uv = gl_FragCoord.xy / u_resolution;
    
    // Making the center 0.0 instead of 0.5, but now the range is -0.5 to 0.5
    uv = uv - 0.5;
    
    // To fix the -0.5 range we multiply by 2.0
    // Now it ranges from -1 to 1 (clip space), 0.0 being the center
    uv = uv * 2.0;
    
    // The 3 above steps can be done in one step
    //vec2 uv = (gl_FragCoord.xy / u_resolution) * 2.0 - 1.0;
    
    // We need to correct the aspect ratio of the screen
    // Handling stretching
    uv.x *= u_resolution.x / u_resolution.y;
    
    // Again we can write all the above (including the stretch handling)
    // in juste one line
    //vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;
    
    //------------------------------------------------------------------
    
    // Save "original" uv value before space repeating has been applied
    vec2 uv0 = uv;
    
    vec3 finalColor = vec3(0.0);
    
    for(float i = 0.0; i <= 5.0; i ++ ) {
        uv = fract(uv * 1.5) - 0.5;
        
        // Distance to repeated spaces (uv has been modified above)
        float d = length(uv) * exp(-length(uv0));
        
        // Setting color with palette function, according to the distance
        // of the current pixel to the center of the canvas (uv0 map to the
        // uv value before space repeating has been applied)
        vec3 color = palette(length(uv0) + i * 0.4 + u_time * 0.4);
        
        d = sin(d * 8.0 + u_time) / 8.0;
        d = abs(d);
        // Neon effect, see 1.0 / x function curve
        // pow function for contrast
        d = pow(0.01 / d, 2.0);
        
        finalColor += color * d; 
    }
    
    // FragColor is the final color of the current pixel
    gl_FragColor = vec4(vec3(finalColor), 1.0);
}