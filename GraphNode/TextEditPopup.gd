extends Window

signal on_update(value: String)

func init(value: String, title_bar: String):
	title = title_bar
	$TextEdit.text = value
	$TextEdit.text_changed.connect(_on_change)
	show()

func _on_change():
	on_update.emit($TextEdit.text)

func change(node: TextEdit):
	$TextEdit.text = node.text

func _on_close_requested():
	hide()
	get_parent().remove_child(self)
	queue_free()
