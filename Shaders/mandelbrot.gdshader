shader_type canvas_item;

uniform float zoom : hint_range(0.1, 100000.0) = 0.4;
uniform vec2 offset = vec2(-0.7, 0.0);
uniform int max_iterations : hint_range(10, 500) = 300;
uniform vec2 viewport_size = vec2(800.0, 800.0);
uniform int c_i : hint_range(0, 2) = 0;

// https://github.com/gsass1/mandelbrot-opengl/blob/master/shader.glsl
vec4 map_to_colour(float t, int i) {
	float c_r;
	float c_g;
	float c_b;
	
	if (i == 0) { // Blue
		c_r = 9.0 * (1.0 - t) * t * t * t;
		c_g = 15.0 * (1.0 - t) * (1.0 - t) * t * t;
		c_b = 8.5 * (1.0 - t) * (1.0 - t) * (1.0 - t) * t;
	} else if (i == 1) { // Green
		c_r = 9.0 * (1.0 - t) * t * t * t;
		c_g = 8.5 * (1.0 - t) * (1.0 - t) * (1.0 - t) * t;
		c_b = 15.0 * (1.0 - t) * (1.0 - t) * t * t;
	} else if (i == 2) { // Red
		c_r = 8.5 * (1.0 - t) * (1.0 - t) * (1.0 - t) * t;
		c_g = 9.0 * (1.0 - t) * t * t * t;
		c_b = 15.0 * (1.0 - t) * (1.0 - t) * t * t;
	}
	
	return vec4(c_r, c_g, c_b, 1.0);
}

void fragment() {
	vec2 frag_coord = FRAGCOORD.xy;
	
	// if (frag_coord.x < 0.0 || frag_coord.x >= viewport_size.x || frag_coord.y < 0.0 || frag_coord.y >= viewport_size.y) {
		//  discard;
	// }
	
	vec2 c = (UV - vec2(0.5, 0.5)) / zoom + offset;
	vec2 z = vec2(0.0, 0.0);
	int iterations = 0;
	
	while (length(z) <= 2.0 && iterations < max_iterations) {
		z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
		// Burning ship:
		// z = vec2(z.x * z.x - z.y * z.y, 2.0 * abs(z.x) * abs(z.y)) + c;
		// distortion possible due to abs(): https://www.reddit.com/r/math/comments/8buizk/why_is_the_burning_ship_fractal_so_messed_up/
		iterations++;
	}
	
	float t = float(iterations) / float(max_iterations);
	
	COLOR = map_to_colour(t, c_i);
}
