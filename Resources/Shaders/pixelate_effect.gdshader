shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 64.0) = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	
	 vec4 tex = texture(TEXTURE, UV);

    if (tex.a < 0.1) {
        discard;
    }
    vec2 screen_res = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 blocks = screen_res / pixel_size;
    vec2 block_uv = floor(SCREEN_UV * blocks) / blocks;
    COLOR = texture(SCREEN_TEXTURE, block_uv);
}
