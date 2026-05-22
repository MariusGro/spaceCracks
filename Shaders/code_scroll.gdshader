shader_type canvas_item;

uniform float speed = 1;

void vertex() {
	UV.y += TIME * speed * - 1.0;
}