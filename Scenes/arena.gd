extends Node2D

@onready var ball: CharacterBody2D = get_node("Ball")
var p1Score: int = 0
var p2Score: int = 0


func _ready() -> void:
	ball.ballOut.connect(update_score)


func update_score() -> void:
	if (ball.global_position.x < 39):
		p2Score += 1
		$P2Score.text = str(p2Score)
	else:
		p1Score += 1
		$P1Score.text = str(p1Score)
