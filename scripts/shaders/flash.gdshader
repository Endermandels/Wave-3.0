shader_type canvas_item;

uniform vec4 flash_color: source_color;
uniform bool active = false;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 new_color = previous_color;
	if (active == true)
	{
		new_color = flash_color;
	}
	COLOR = new_color;
}