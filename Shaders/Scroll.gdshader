shader_type canvas_item;

uniform float speed = 1;

void vertex() {
	UV.y += TIME * speed;
	UV.x += sin(TIME * speed / 2.0);
}
