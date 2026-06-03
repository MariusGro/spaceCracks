shader_type canvas_item;

uniform float speed = 1;
uniform bool shader_process = true;

void vertex() {
	if (shader_process) {
		UV.x += sin(TIME * speed / 2.0);
		UV.y += TIME * speed;
	}
}
