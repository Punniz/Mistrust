shader_type canvas_item;

uniform sampler2D gradient;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 gradientColor = texture(gradient, UV);
	COLOR = pixelColor + gradientColor * 0.3;
}