shader_type canvas_item;
uniform float whiteness : hint_range(0.0,1.0) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 p = texture(screen_texture, SCREEN_UV);
    vec3 white = vec3(1.0);
    vec3 result = mix(p.rgb, white, whiteness);
    COLOR = vec4(result, p.a);

}
