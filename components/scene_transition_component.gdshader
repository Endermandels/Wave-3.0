shader_type canvas_item;

/**
* 0 = CIRCLE_OUT
* 1 = CIRCLE_IN
* 2 = INVERSE_CIRCLE_OUT
*/
group_uniforms INTERNAL;
uniform int transition_type: hint_enum("CIRCLE_OUT", "CIRCLE_IN", "INVERSE_CIRCLE_OUT") = 0;
uniform float progress: hint_range(0, 1) = 0.0;
uniform vec2 screen_size;
group_uniforms;

const vec2 center = vec2(0.5, 0.5);

void circle_out(vec2 uv) {
	// Convert pixel position to raw value
	vec2 pixel_pos = uv * screen_size;
	vec2 pixel_center = center * screen_size;

	// Get the distance of the pixel from the center
	float dist = distance(pixel_pos, pixel_center);

	// If the pixel is outside the radius, remove it
	if (dist > progress * screen_size.x) {
		discard;
	}
}

void circle_in(vec2 uv) {
	// Convert pixel position to raw value
	vec2 pixel_pos = uv * screen_size;
	vec2 pixel_center = center * screen_size;

	// Get the distance of the pixel from the center
	float dist = distance(pixel_pos, pixel_center);

	// If the pixel is outside the radius, remove it (reversed direction)
	if (dist > (1.0 - progress) * screen_size.x) {
		discard;
	}
}

void inverse_circle_out(vec2 uv) {
	// Convert pixel position to raw value
	vec2 pixel_pos = uv * screen_size;
	vec2 pixel_center = center * screen_size;

	// Get the distance of the pixel from the center
	float dist = distance(pixel_pos, pixel_center);

	// If the pixel is inside the radius, remove it
	if (dist < progress * screen_size.x) {
		discard;
	}
}

void fragment() {
	// Called for every pixel the material is visible on.

	// Get pixel position (normalized)
	vec2 uv = UV;

	if (transition_type == 0)
	{
		circle_out(uv);
	}
	else if (transition_type == 1)
	{
		circle_in(uv);
	}
	else if (transition_type == 2)
	{
		inverse_circle_out(uv);
	}

	COLOR = COLOR;
}
