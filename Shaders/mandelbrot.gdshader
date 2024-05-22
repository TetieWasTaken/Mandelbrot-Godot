shader_type canvas_item;

uniform float zoom : hint_range(0.1, 10.0) = 0.4;
uniform vec2 offset = vec2(-0.7, 0.0);
uniform int max_iterations : hint_range(1, 1000) = 100;
uniform vec4 color1 : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Color for points inside the Mandelbrot set
uniform vec4 color2 : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Color for points outside the Mandelbrot set

void fragment() {
    vec2 c = (UV - vec2(0.5, 0.5)) / zoom + offset;
    vec2 z = vec2(0.0, 0.0);
    int iterations = 0;

    while (length(z) <= 2.0 && iterations < max_iterations) {
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
        iterations++;
    }

    float t = float(iterations) / float(max_iterations);
    vec4 color = mix(color2, color1, t);
    COLOR = color;
}
