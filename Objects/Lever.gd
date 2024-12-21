extends Area2D

@export var object_id: String
@export var start_state: bool

var state: bool
var can_latch: bool

func _ready() -> void:
	state = start_state
	animate()
	await get_tree().process_frame
	Global.latch.emit(state, object_id)

func _on_body_entered(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	can_latch = true

func _on_body_exited(body: Node2D):
	if not body is Player:
		return
	can_latch = false


func _input(event: InputEvent):
	if not can_latch:
		return
	if not event is InputEventKey:
		return
	if event.pressed:
		return
	if event.keycode != KEY_E:
		return
	state = not state
	Global.latch.emit(state, object_id)
	animate()

func animate():
	get_tree().create_tween().tween_property($Line2D, "rotation_degrees", 30 if state else -30 , Global.anim_speed).set_trans(Tween.TRANS_CUBIC)
