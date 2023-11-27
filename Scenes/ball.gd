extends CharacterBody2D

var speed: int = 100

func _ready() -> void:
	randomize()
	var initalDirection: int = randi_range(0, 1)

	if initalDirection:
		velocity = Vector2(1, 0) * speed
	else:
		velocity = Vector2(-1, 0) * speed

func _physics_process(_delta) -> void:
	move_and_slide()

func _on_area_2d_area_entered(area):
	var body: Node = area.get_parent()

	if (body is CharacterBody2D):
		var spriteMiddle: int = body.global_position.y + 16
		var difference: int = global_position.y - spriteMiddle
		velocity.x = velocity.x * -1
		if (difference > 0):
			velocity.y = abs(velocity.y)
			velocity.y += difference * 2
		elif (difference < 0):
			velocity.y = abs(velocity.y) * -1
			velocity.y = velocity.y + (difference * 2)
