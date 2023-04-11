extends Camera3D


@export var Target: Node3D


func _process(_delta: float) -> void:
	if(is_instance_valid(Target)):
		look_at(Target.position)
