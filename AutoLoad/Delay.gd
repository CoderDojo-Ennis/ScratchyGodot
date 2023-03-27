extends Node


## Wait for some Seconds
func Seconds(sec: float) -> void:
	await get_tree().create_timer(sec).timeout


## Wait for the next frame
func NextFrame() -> void:
	await get_tree().process_frame


## Wait for the next physics frame
func NextPhysicsFrame() -> void:
	await get_tree().physics_frame
