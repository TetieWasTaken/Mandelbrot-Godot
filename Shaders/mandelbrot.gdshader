shader_type canvas_item;

uniform float zoom : hint_range(0.1, 10.0) = 0.4;
uniform vec2 offset = vec2(-0.7, 0.0);
uniform int max_iterations : hint_range(1, 1000) = 100;
uniform vec2 viewport_size = vec2(800.0, 800.0);

// https://github.com/gsass1/mandelbrot-opengl/blob/master/shader.glsl
vec4 map_to_colour(float t) {
    float r = 9.0 * (1.0 - t) * t * t * t;
    float g = 15.0 * (1.0 - t) * (1.0 - t) * t * t;
    float b = 8.5 * (1.0 - t) * (1.0 - t) * (1.0 - t) * t;

    return vec4(r, g, b, 1.0);
}

void fragment() {
    vec2 frag_coord = FRAGCOORD.xy;

    if (frag_coord.x < 0.0 || frag_coord.x >= viewport_size.x || frag_coord.y < 0.0 || frag_coord.y >= viewport_size.y) {
        discard;
    }

    vec2 c = (UV - vec2(0.5, 0.5)) / zoom + offset;
    vec2 z = vec2(0.0, 0.0);
    int iterations = 0;

    while (length(z) <= 2.0 && iterations < max_iterations) {
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
        iterations++;
    }

    float t = float(iterations) / float(max_iterations);
    // vec3 rainbow_color = vec3(0.5 + 0.5 * cos(3.0 + t * 3.0), 0.5 + 0.5 * cos(8.0 + t * 3.0), 0.5 + 0.5 * cos(5.0 + t * 3.0));

    COLOR = map_to_colour(t);
}
