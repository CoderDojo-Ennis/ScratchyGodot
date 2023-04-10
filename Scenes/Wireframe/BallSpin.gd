extends CSGSphere3D

@export var move_range: float = 2
@export var speed: float = 2

var age: float = 0
var home: Vector3
var rot: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	home = position;
	rot = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	age = age + delta
	position = home + Vector3(move_range * sin(age * speed), 0, 0)
	rotation = rot + Vector3(age * speed, 0, 0)

