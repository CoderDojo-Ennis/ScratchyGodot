extends CharacterBody2D

@export var speed: float = 50
@onready var animationPlayer = $AnimationPlayer

func _ready():
	pass

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()

func handleInput():
	var moveDirection: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func updateAnimation():
	if velocity.length() == 0:
		animationPlayer.pause()
	elif velocity.x < 0:
		animationPlayer.play("WalkLeft")
	elif velocity.x > 0:
		animationPlayer.play("WalkRight")
	elif velocity.y < 0:
		animationPlayer.play("WalkUp")
	else:
		animationPlayer.play("WalkDown")
