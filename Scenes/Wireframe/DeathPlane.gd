extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(OnBodyEntered)

func OnBodyEntered(object: Node):
	print("DeathPlane - Area Entered")
	Events.DeathPlaneHit.emit(self, object)

