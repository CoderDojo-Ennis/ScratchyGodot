extends Node

# Pause for some time
func Seconds(seconds: float):
	await get_tree().create_timer(seconds).timeout

