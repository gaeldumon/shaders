#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution;
    float y=(sin(st.x*PI*10.)/sin(st.y*PI*10.))*100.;
    vec3 final=vec3(y);
    gl_FragColor=vec4(final,1.);
}