extends StaticBody2D
class_name Door


@export var state: State
@export var object_id: String
@export var object_group: String
@export var item_id: String

enum State {
	OPEN = 1,
	CLOSE = 0,
}

func _ready():
	Global.animate.connect(on_animate)
	Global.latch.connect(on_latch)
	Global.pick.connect(on_pick)

func on_animate(clock: int):
	get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0) if state else Color(0.75, 0.75, 0.75, 1), Global.anim_speed)

func on_latch(on: bool, id: String, group: String):
	if id != object_id and (group != object_group or object_group.is_empty()):
		return
	state = 1 if on else 0
	set_collision_layer_value(2, not bool(state))
	
func on_pick(item: String):
	if item != item_id:
		return
	state = abs(state - 1)
	set_collision_layer_value(2, not bool(state))
