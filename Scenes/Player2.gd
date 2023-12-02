extends CharacterBody2D

@export var speed: int = 70

func handle_movement() -> void:
	var direction: int = 0
	if (Input.is_action_pressed("p2Down")):
		direction = 1
	elif (Input.is_action_pressed("p2Up")):
		direction = -1
	velocity.y = direction * speed

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	handle_movement()
	move_and_slide()
