extends CanvasLayer

@export var speed: float

var proccesing: bool = false

func _ready():
	get_tree().root.size_changed.connect(root_changed)

func change_scene(path: String):
	if proccesing:
		return
	proccesing = true
	$ColorRect.position = Vector2(DisplayServer.window_get_size().x, 0)
	$ColorRect.visible = true
	var tween = get_tree().create_tween()
	print("called")
	tween.tween_property($ColorRect, "position:x", 0, speed).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(get_tree().change_scene_to_file.bind(path))
	#tween.tween_property($ColorRect, "position:x", 0, 0)
	tween.tween_property($ColorRect, "position:x", -$ColorRect.size.x, speed).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($ColorRect, "visible", false, 0)
	tween.tween_property(self, "proccesing", false, 0)

func root_changed():
	$ColorRect.custom_minimum_size = get_tree().root.size
