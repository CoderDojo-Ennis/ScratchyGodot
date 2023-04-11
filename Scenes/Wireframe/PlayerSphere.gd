extends RigidBody3D

@export var Speed: float = 50.0;

@onready var PlayerSphere: CSGSphere3D = $PlayerSphere
@onready var DeathSound: AudioStreamPlayer3D = $DeathSound
@onready var CollisionSound: CollisionSoundPlayer = $CollisionSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.DeathPlaneHit.connect(OnDeathPlaneHit)
	body_entered.connect(OnCollision)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	var torque: Vector2 = input * Speed * delta;
	angular_velocity.x += torque.y;
	angular_velocity.z -= torque.x;
	#apply_torque(Vector3(torque.x, torque.y, 0));


func OnDeathPlaneHit(_deathPlane: Node, object: Node):
	if (object.name == name):
		print("Player - Death hit")
		await Die()


func Die():
	print("Death animation start")
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	tween.tween_property(self, "angular_velocity", Vector3.ZERO, 1.0)
	tween.tween_property(self, "linear_velocity", Vector3.ZERO, 1.0)
	tween.tween_method(SetCoverage, 0.8, 0.005, 0.5)
	tween.tween_method(SetFlickerSpeed, 20.0, 0.1, 1.0)
	DeathSound.play()
	await DeathSound.finished
	# await tween.finished # Not working with set_parallel
	await Delay.Seconds(2)
	tween.stop()
	print("Death animation finished")
	Events.PlayerDied.emit()
	queue_free()


func SetCoverage(coverage: float):
	PlayerSphere.set_instance_shader_parameter("coverage", coverage)

func SetFlickerSpeed(flickerSpeed: float):
	PlayerSphere.set_instance_shader_parameter("speed", flickerSpeed)


func OnCollision(_other: Node):
	pass
	#CollisionSound.PlayCollisionSound()


var prev_linear_velocity: Vector3 = Vector3.ZERO


func _integrate_forces(_state)->void:
	var magnitude = (prev_linear_velocity - linear_velocity).length()
	prev_linear_velocity = linear_velocity
	if (magnitude > 1):
		print("Ball collision magnitude: " + str(magnitude))
	if (magnitude > 2):
		CollisionSound.PlayCollisionSound(magnitude)
