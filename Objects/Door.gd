extends StaticBody2D
class_name Door

@export var state: State
@export var object_id: String

enum State {
	OPEN = 1,
	CLOSE = 0,
}

func _ready():
	Global.latch.connect(on_latch)

func animate():
	get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0) if state else Color(0.75, 0.75, 0.75, 1), Global.anim_speed)

func on_latch(on: bool, id: String):
	if id != object_id:
		return
	state = State.OPEN if on else State.CLOSE
	set_collision_layer_value(2, not bool(state))
	animate()
