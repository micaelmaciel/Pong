extends CharacterBody2D

signal ballOut

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

func reinitialize_ball() -> void:
	randomize()
	position = Vector2(240, 135)
	var randomSide: int = -1 if(randi_range(0, 1) == 0) else 1
	var randomDirectionX: int = randi_range(1, 9) * randomSide
	var randomDirectionY: int = randi_range(1, 9) * randomSide
	velocity = Vector2(randomDirectionX, randomDirectionY).normalized()
	velocity.x *= initialSpeed
	velocity.y *= initialSpeed/2


func _ready() -> void:
	initialize_ball()


func _physics_process(_delta) -> void:
	move_and_slide()

func _on_area_2d_area_entered(area) -> void:
	var body: Node = area.get_parent()

	if (body is CharacterBody2D):
		print(global_position.x - 5)
		if (global_position.x + 5 < 416 and global_position.x - 5 > 65): #8 represents 6, which is half the size of the ball, + 2 tolerance...
			if (velocity.y == 0): 									 #so, the difference between the far left/right of the ball and of the paddle
				velocity.y = initialSpeed/2
			velocity.x += speedGain * sign(velocity.x)
			velocity.y += speedGain * sign(velocity.y)
			velocity.x = velocity.x * -1
	elif (body is StaticBody2D):
		velocity.y *= -1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	emit_signal("ballOut")
	reinitialize_ball()
