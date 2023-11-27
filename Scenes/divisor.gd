extends VBoxContainer

var singleDivisor := preload("res://Scenes/single_divisor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var _add_constant_central_forcedivisor := singleDivisor.instantiate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
