extends Area2D
class_name Key


@export var output_id: String
@export var output_signal: bool = true
@export var custom_texture: Texture2D
const wiggle: float = 8

func _ready():
	Global.animate.connect(on_animate)
	
func on_animate(clock: int):
	if clock % 2 == 1:
		return
	get_tree().create_tween().tween_property($Sprite2D, "position:y", wiggle if clock % 4 else -wiggle, Global.anim_speed * 2).set_trans(Tween.TRANS_CUBIC)


func _on_body_entered(body: Node2D):
	if body is Player:
		Global.latch.emit(output_signal, output_id)
		await get_tree().create_tween().tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 1.0).finished
		queue_free()
