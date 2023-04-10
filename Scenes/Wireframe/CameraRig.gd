extends Marker3D

@export var Target: Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, Target.global_position, 0.05)
