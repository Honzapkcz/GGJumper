extends Area2D
class_name Key


@export var item_id: String
const wiggle: float = 8

func _ready():
	Global.animate.connect(on_animate)
	
func on_animate(clock: int):
	if clock % 2 == 1:
		return
	get_tree().create_tween().tween_property($Sprite2D, "position:y", wiggle if clock % 4 else -wiggle, Global.anim_speed * 2).set_trans(Tween.TRANS_CUBIC)


func _on_body_entered(body: Node2D):
	if body is Player:
		Global.pick.emit(item_id)
		await get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 1.0).finished
		queue_free()
