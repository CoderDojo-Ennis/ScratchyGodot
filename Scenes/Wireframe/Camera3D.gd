extends Camera3D


@export var Target: Node3D


func _process(_delta: float) -> void:
	look_at(Target.position)
