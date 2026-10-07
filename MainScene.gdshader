shader_type canvas_item;

uniform float wave_speed : hint_range(0.5, 5.0) = 2.0;
uniform float wave_frequent : hint_range(1.0, 30.0) = 15.0;
uniform float wave_amp : hint_range(0.0, 10.0) = 1.5;

void vertex() {
	VERTEX.y += sin(VERTEX.x * wave_frequent * 0.01 + TIME * wave_speed) * wave_amp;
}

void fragment() {
	COLOR = vec4(0.7, 0.9, 1.0, 0.75);
}
