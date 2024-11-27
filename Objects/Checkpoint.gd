extends Area2D

@export var level = 0
var visited: bool

func _on_body_entered(body):
	if not body is Player:
		return
	Global.checkpoint.emit(position, level)
	if visited:
		return
	visited = true
	get_tree().create_tween().tween_property($Flag, "position:y", -8, 0.5).set_trans(Tween.TRANS_CUBIC)
	get_tree().create_tween().tween_property($Flag, "color", Color8(192, 192, 192), 0.5).set_trans(Tween.TRANS_CUBIC)
