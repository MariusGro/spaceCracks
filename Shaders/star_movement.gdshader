shader_type canvas_item;

uniform float speed = 1;
uniform float direction = 1;

void vertex() {
	UV.x += TIME * speed * direction + sin(TIME * speed);
	UV.y += TIME * speed * direction;
}