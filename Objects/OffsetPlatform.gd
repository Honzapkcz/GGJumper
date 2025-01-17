extends StaticBody2D
class_name OffsetPlatform

@export var respawn_offset: Vector2
@export var state: State
@export var object_id: String

var origin: Vector2

enum State {
	VISIBLE = 0,
	HIDDEN = 1,
}

func _ready():
	Global.latch.connect(on_latch)
	Global.respawn.connect(on_respawn)
	origin = position
	on_respawn()

func animate():
	get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0) if state else Color(1, 1, 1, 1), 1.0)

func on_latch(on: bool, id: String):
	if id != object_id:
		return
	state = State.VISIBLE if on else State.HIDDEN
	$CollisionShape2D.disabled = state
	animate()

func on_respawn():
	var pos = origin
	pos += Vector2(randf_range(-respawn_offset.x, respawn_offset.x), randf_range(-respawn_offset.y, respawn_offset.y))
	get_tree().create_tween().tween_property(self, ^"position", pos, Global.anim_speed * 2).set_trans(Tween.TRANS_CUBIC)
