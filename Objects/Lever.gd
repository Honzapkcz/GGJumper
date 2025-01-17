extends Area2D

@export var object_id: String
@export var start_state: bool

var state: bool
var can_latch: bool

func _ready() -> void:
	latch(start_state)

func _on_body_entered(body: Node2D):
	if not body is Player:
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
	latch(not state)

func latch(on: bool):
	state = on
	Global.latch.emit(state, object_id)
	get_tree().create_tween().tween_property($Line2D, "rotation_degrees", 30 if state else -30 , Global.anim_speed).set_trans(Tween.TRANS_CUBIC)
