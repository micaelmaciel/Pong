extends CharacterBody2D

signal ballOut

@export var initialSpeed: int = 100
@export var speedGain: int = 10

#region ball start
func initialize_ball() -> void:
	randomize()
	position = Vector2(240, 135)
	var initalDirection: int = randi_range(0, 1)

	if initalDirection:
		velocity = Vector2(1, 0) * initialSpeed
	else:
		velocity = Vector2(-1, 0) * initialSpeed

func reinitialize_ball() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	randomize()
	position = Vector2(240, 135)
	var randomSide: int = -1 if(randi_range(0, 1) == 0) else 1
	var randomDirectionX: int = randi_range(1, 9) * randomSide
	var randomDirectionY: int = randi_range(1, 9) * randomSide
	velocity = Vector2(randomDirectionX, randomDirectionY).normalized()
	velocity.x *= initialSpeed
	velocity.y *= initialSpeed/2
#endregion

func handle_collision(collision: KinematicCollision2D) -> void:
	var normal: Vector2 = collision.get_normal()
	var collider: Object = collision.get_collider()
	
	if (collider is CharacterBody2D):
		if (normal.x != 0 and (normal.y != 1 and normal.y != -1)):
			if (velocity.y == 0):
				velocity.y = initialSpeed/2
			velocity.x += speedGain * sign(velocity.x)
			velocity.y += speedGain * sign(velocity.y)
			velocity.x = velocity.x * -1
		else:
			$CollisionShape2D.set_deferred("disabled", true)

	elif (collider is StaticBody2D):
		velocity.y *= -1

func _ready() -> void:
	initialize_ball()


func _physics_process(delta) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if (collision):
		handle_collision(collision)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	emit_signal("ballOut")
	reinitialize_ball()
