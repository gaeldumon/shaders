'use strict'

const canvasConfig = {
    width: 232,
    height: 232
}

const shaderPaths = [
    "../1_color_feeling/color_feeling.glsl",
    "../2_gradients/william_turner_sunset.glsl",
    "../checkerboard/checkerboard.glsl"
]

const mainWrapper = document.getElementById("main-wrapper");
let canvas;

for (let shader of shaderPaths) {
    canvas = document.createElement("canvas");

    // This is actually how we use the GlslCanvas library
    canvas.setAttribute("class", "glslCanvas");

    // Path to the fragment shader we want to display
    canvas.setAttribute("data-fragment-url", shader);

    canvas.setAttribute("width", canvasConfig.width);
    canvas.setAttribute("height", canvasConfig.height);

    mainWrapper.appendChild(canvas);
}