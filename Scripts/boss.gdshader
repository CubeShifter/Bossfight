shader_type canvas_item;

uniform bool enabled = false;
uniform float power = 1;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    if (enabled) {
		COLOR = vec4(1,1,1,power*tex.a);
	} else {
		COLOR = vec4(tex.r,tex.g,tex.b,power*tex.a);
	}

}
