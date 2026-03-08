shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture;
uniform float power = 0;

void fragment() {
	vec4 p = texture(screen_texture, SCREEN_UV);
	COLOR = vec4(p.r*(1.0+(0.2*power)),p.g*(1.0-(0.2*power)),p.b*(1.0-(0.2*power)),1);



}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
