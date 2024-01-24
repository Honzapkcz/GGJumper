extends Area2D

@export var object_id: String
@export var object_group: String

var state: bool

func _ready():
	Global.animate.connect(on_animate)

func _on_body_entered(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	state = true
	Global.latch.emit(true, object_id, object_group)


func _on_body_exited(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	state = false
	Global.latch.emit(false, object_id, object_group)

func on_animate(clock: int):
	get_tree().create_tween().tween_property($Sprite2D, "position:y", -16 - 16 * int(not state), 0.5).set_trans(Tween.TRANS_CUBIC)
