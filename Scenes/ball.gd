extends CharacterBody2D

@export var initialSpeed: int = 100
@export var speedGain: int = 10


func initialize_ball() -> void:
	randomize()
	position = Vector2(240, 135)
	var initalDirection: int = randi_range(0, 1)

	if initalDirection:
		velocity = Vector2(1, 0) * initialSpeed
	else:
		velocity = Vector2(-1, 0) * initialSpeed

func _ready() -> void:
	initialize_ball()


func _physics_process(_delta) -> void:
	move_and_slide()
	print(velocity)

func _on_area_2d_area_entered(area) -> void:
	var body: Node = area.get_parent()
	print(global_position.x)

	if (body is CharacterBody2D) and (global_position.x + 6 <= 415 and global_position.x - 6 >= 73):
		if (velocity.y == 0):
			velocity.y = initialSpeed/2
		velocity.x += speedGain * sign(velocity.x)
		velocity.y += speedGain * sign(velocity.y)
		velocity.x = velocity.x * -1
	elif (body is StaticBody2D):
		velocity.y *= -1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	initialize_ball()
