extends Area2D

@export var object_id: String

var state: bool
var bodies: int = 0

func _on_body_entered(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	bodies += 1
	state = true
	Global.latch.emit(true, object_id)
	animate()


func _on_body_exited(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	bodies -= 1
	if not bodies:
		state = false
		Global.latch.emit(false, object_id)
		animate()

func animate():
	get_tree().create_tween().tween_property($Sprite2D, "position:y", -16 - 16 * int(not state), Global.anim_speed).set_trans(Tween.TRANS_CUBIC)
