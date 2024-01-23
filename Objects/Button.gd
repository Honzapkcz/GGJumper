extends Area2D

@export var object_id: String
@export var object_group: String


func _on_body_entered(body: Node2D):
	if not body is Player:
		return
	Global.latch.emit(true, object_id, object_group)


func _on_body_exited(body: Node2D):
	if not body is Player:
		return
	Global.latch.emit(false, object_id, object_group)
