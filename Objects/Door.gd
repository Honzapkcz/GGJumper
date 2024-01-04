extends StaticBody2D
class_name Door


@export var state: State
@export var object_id: String
@export var object_group: String

enum State {
	OPEN = 0,
	CLOSE = 1,
}

func _ready():
	Global.animate.connect(on_animate)
	Global.latch.connect(on_latch)

func on_animate(clock: int):
	get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 1) if state else Color(1, 1, 1, 0), 1.0)

func on_latch(on: bool, id: String, group: String):
	if id != object_id and group != object_group:
		return
	state = 0 if on else 1

