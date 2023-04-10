shader_type spatial;
render_mode wireframe, unshaded, cull_disabled;

instance uniform vec4 laser_color: source_color = vec4(1.0, 0.0, 0.0, 1.0);
instance uniform float vertex_count = 630.0;
instance uniform float coverage = 0.9;
instance uniform float speed = 20;
instance uniform float back_opacity = 0.05;
instance uniform float flicker = .01;

varying float vis;

void vertex() {

	float perc = mod((float(VERTEX_ID) + TIME * speed * vertex_count), vertex_count) / vertex_count;
	vis = perc <= coverage ? 1.0 : 0.0;

	// Flicker
	float t = (sin(TIME * 200.0 + float(VERTEX_ID)) + 1.0);
	if (t < flicker) {
		vis = 0.0;
	}
	
	VERTEX = VERTEX * 1.02;
}

void fragment() {
	if (vis < 0.5) {
		discard;
	} else {
		EMISSION = vec3(0, 10, 100);
		ALBEDO = laser_color.rgb;
		ALPHA = mix(1.0, back_opacity, FRONT_FACING ? 0.0 : 1.0);
	}
}