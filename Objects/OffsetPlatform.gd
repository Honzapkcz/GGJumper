extends StaticBody2D
class_name OffsetPlatform

@export var respawn_offset: Vector2
@export var state: State
@export var object_id: String
@export var object_group: String
var origin: Vector2

enum State {
	VISIBLE = 0,
	HIDDEN = 1,
}

func _ready():
	Global.animate.connect(on_animate)
	Global.latch.connect(on_latch)
	Global.respawn.connect(on_respawn)
	origin = position
	on_respawn()

func on_animate(clock: int):
	get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0) if state else Color(1, 1, 1, 1), 1.0)

func on_latch(on: bool, id: String, group: String):
	if id != object_id and group != object_group:
		return
	state = 0 if on else 1
	$CollisionShape2D.disabled = state

func on_respawn():
	position = origin
	position += Vector2(randf_range(-respawn_offset.x, respawn_offset.x), randf_range(-respawn_offset.y, respawn_offset.y))
