shader_type spatial;
render_mode wireframe, unshaded, cull_disabled;

uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 wire_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
//uniform float wire_width : hint_range(0.0, 40.0) = 5.0;
//uniform float wire_smoothness : hint_range(0.0, 0.1) = 0.01;

varying float vis;
varying vec3 barys;

void vertex() {
	int index = VERTEX_ID % 3;
	switch (index) {
		case 0:
			barys = vec3(1.0, 0.0, 0.0);
			break;
		case 1:
			barys = vec3(0.0, 1.0, 0.0);
			break;
		case 2:
			barys = vec3(0.0, 0.0, 1.0);
			break;
	}

	//float t = (sin(TIME * 200.0) * 0.5 + 0.5) * 3.0;
	//if (index == int(t)) {
	//	vis = 1.0;
	//} else {
	//	vis = 0.0;
	//}

	float t = (sin(TIME * 200.0 + float(VERTEX_ID) * 2.0 + float(index * 3)));
	vis = 0.0;
	if (t > 0.5) {
		vis = 1.0;
	}
}

void fragment() {
	//vec3 deltas = fwidth(barys);
	//vec3 barys_s = smoothstep(deltas * wire_width - wire_smoothness, deltas * wire_width + wire_smoothness, barys);
	//float wires = min(barys_s.x, min(barys_s.y, barys_s.z));
	// ALBEDO = mix(wire_color.rgb, albedo.rgb, wires);
	// ALPHA = mix(1.0, 0.5, wires);
	if (vis < 0.5) {
		ALPHA = 0.0;
	} else {
		ALPHA = mix(1.0, .5, FRONT_FACING ? 0.0 : 1.0);
		ALBEDO = mix(wire_color.rgb, albedo.rgb, FRONT_FACING ? 0.0 : 1.0);
	}
}