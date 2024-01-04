extends Area2D

@export var level = 0

func _on_body_entered(body):
	if body is Player:
		Global.checkpoint.emit(position, level)
