extends TileMapLayer
class_name Platform

@export var state: State
@export var object_id: String

enum State {
	VISIBLE = 0,
	HIDDEN = 1,
}

func _ready():
	Global.latch.connect(on_latch)
	animate()

func animate():
	get_tree().create_tween().tween_property(self, "modulate", Color(1, 1, 1, 0) if state else Color(1, 1, 1, 1), 1.0)

func on_latch(on: bool, id: String):
	if id != object_id:
		return
	state = State.VISIBLE if on else State.HIDDEN
	enabled = state == State.VISIBLE
	animate()
