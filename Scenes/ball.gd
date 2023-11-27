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

func _on_area_2d_area_entered(area) -> void:
	var body: Node = area.get_parent()

	if (body is CharacterBody2D):
		if (velocity.y == 0):
			velocity.y = speed/2
		var spriteMiddle: int = body.global_position.y + body.get_node("Sprite2D").get_rect().size.y/2
		var difference: int = global_position.y - spriteMiddle
		velocity.x = velocity.x * -1
