extends CanvasLayer

@export var speed: float

func change_scene(path: String):
	$ColorRect.position = Vector2(DisplayServer.window_get_size().x, 0)
	$ColorRect.visible = true
	var tween = get_tree().create_tween()
	print("called")
	tween.tween_property($ColorRect, "position:x", 0, speed).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(get_tree().change_scene_to_file.bind(path))
	#tween.tween_property($ColorRect, "position:x", 0, 0)
	tween.tween_property($ColorRect, "position:x", -$ColorRect.size.x, speed).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($ColorRect, "visible", false, 0)
