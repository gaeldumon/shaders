#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    
    float strength = 0.0;
    
    // LEFT GRADIENT
    //strength = uv.x;
    
    // RIGHT GRADIENT
    //strength = uv.y;
    
    // TOP GRADIENT
    //strength = 1.0 - uv.y;
    
    // BOTTOM SQUEEZED GRADIENT (MULTIPLY THE VALUE)
    //strength = uv.y * 10.0;
    
    // GRADIENT REPEATED HORIZONTALLY
    // Use a modulo to repeat a gradient.
    // It finds remainder after division of the 1st arg by the 2nd arg.
    // Like having the 1st number going back to zero once it reaches
    // the 2nd number.
    //strength = mod(uv.y * 10.0, 1.0);
    
    // HORIZONTAL STRIPES
    // Variate the 1st arg to change the higher edge value for the step.
    //strength = step(0.8, mod(uv.y * 10.0, 1.0));
    
    // VERTICAL STRIPES
    //strength = step(0.8, mod(uv.x * 10.0, 1.0));
    
    // GRID
    // Add the x and y to create a grid
    //strength = step(0.8, mod(uv.y * 10.0, 1.0)) + step(0.8, mod(uv.x * 10.0, 1.0));
    
    // DOTS
    // Multiply to only see the intersections
    //strength = step(0.8, mod(uv.y * 10.0, 1.0)) * step(0.8, mod(uv.x * 10.0, 1.0));
    
    // Variate the step 1st edges values for each axis
    //strength = step(0.8, mod(uv.x * 10.0, 1.0)) * step(0.4, mod(uv.y * 10.0, 1.0));
    
    //float barX = step(0.4, mod(uv.x * 10.0, 1.0)) * step(0.8, mod(uv.y * 10.0, 1.0));
    //float barY = step(0.8, mod(uv.x * 10.0, 1.0)) * step(0.4, mod(uv.y * 10.0, 1.0));
    //strength = barX + barY;
    
    // Small offset on x/y axis of the bars to create crosses
    //float barX = step(0.4, mod(uv.x * 10.0 - 0.2, 1.0)) * step(0.8, mod(uv.y * 10.0, 1.0));
    //float barY = step(0.8, mod(uv.x * 10.0, 1.0)) * step(0.4, mod(uv.y * 10.0 - 0.2, 1.0));
    //strength = barX + barY;
    
    // GRADIENT BY THE MIDDLE (BLACK)
    //strength = abs(uv.x - 0.5);
    
    // GRADIENT BY THE MIDDLE (WHITE)
    //strength = 1.0 - abs(uv.x - 0.5);
    
    // GRADIENTS CROSS
    //strength = min(abs(uv.x - 0.5), abs(uv.y - 0.5));
    
    //strength = max(abs(uv.x - 0.5), abs(uv.y - 0.5));
    
    strength = step(0.2, max(abs(uv.x - 0.5), abs(uv.y - 0.5)));
    
    gl_FragColor = vec4(vec3(strength), 1.0);
}