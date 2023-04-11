extends AudioStreamPlayer3D
class_name CollisionSoundPlayer


@export var Sounds: Array[AudioStream];


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func PlayCollisionSound(vol: float):
	stream = Sounds.pick_random()
	const maxHit: float = 10
	volume_db = remap(min(vol, maxHit), 0, maxHit, -60, 80)
	play()
