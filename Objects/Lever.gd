extends Area2D

@export var object_id: String
@export var object_group: String

var state: bool
var can_latch: bool

func _ready():
	Global.animate.connect(on_animate)

func _on_body_entered(body: Node2D):
	if not (body is Player or body is RigidBody2D):
		return
	can_latch = true

func _on_body_exited(body: Node2D):
	if not body is Player:
		return
	can_latch = false


func _input(event: InputEvent):
	if not event is InputEventKey:
		return
	if event.pressed:
		return
	if event.keycode != KEY_E:
		return
	state = not state
	Global.latch.emit(state, object_id, object_group)

func on_animate(clock: int):
	get_tree().create_tween().tween_property($Line2D, "rotation_degrees", 30 if state else -30 , Global.anim_speed).set_trans(Tween.TRANS_CUBIC)
