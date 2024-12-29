@tool
extends Container
## F**king hell
## Might refractor later
class_name HSplit3Container

var splitter_focus: int
var dragging: bool
@export var splitter_width: float = 5:
	set(value):
		splitter_width = value
		_notification(NOTIFICATION_CHILD_ORDER_CHANGED)
@export var splitter_stylebox: StyleBoxLine:
	set(value):
		splitter_stylebox = value
		update_configuration_warnings()
@export var split_offset_left: float = 25:
	set(value):
		split_offset_left = value
		_notification(NOTIFICATION_CHILD_ORDER_CHANGED)
@export var split_offset_right: float = 25:
	set(value):
		split_offset_right = value
		_notification(NOTIFICATION_CHILD_ORDER_CHANGED)


func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		if get_child_count() != 3:
			return
		fit_child_in_rect(get_child(0), Rect2(Vector2(0, 0), Vector2(split_offset_left, size.y)))
		fit_child_in_rect(get_child(1), Rect2(Vector2(split_offset_left + splitter_width, 0), Vector2(size.x - split_offset_left - splitter_width * 2 - split_offset_right, size.y)))
		fit_child_in_rect(get_child(2), Rect2(Vector2(size.x - split_offset_right, 0), Vector2(split_offset_right, size.y)))
	elif what == NOTIFICATION_DRAW:
		if not splitter_stylebox:
			return
		if splitter_focus == 1:
			draw_style_box(splitter_stylebox, Rect2(Vector2(split_offset_left + splitter_width / 2 - splitter_stylebox.thickness / 2, 0), Vector2(splitter_width, size.y)))
		elif splitter_focus == 2:
			draw_style_box(splitter_stylebox, Rect2(Vector2(size.x - split_offset_right - splitter_width + splitter_width / 2 - splitter_stylebox.thickness / 2, 0), Vector2(splitter_width, size.y)))
	elif what == NOTIFICATION_CHILD_ORDER_CHANGED:
		queue_sort()
		queue_redraw()
		update_configuration_warnings()

## Cover your eyes please
func _gui_input(e: InputEvent) -> void:
	if e is InputEventMouseMotion:
		var event: = e as InputEventMouseMotion
		
		if dragging:
			if splitter_focus == 1 and split_offset_left - event.relative.x > 0 and event.relative.x < 0 or size.x - split_offset_left - split_offset_right - 2 * splitter_width - event.relative.x > 2:
				split_offset_left += event.relative.x
			elif splitter_focus == 2 and split_offset_right + event.relative.x < size.x and event.relative.x > 0 or size.x - split_offset_left - split_offset_right - 2 * splitter_width + event.relative.x > 2:
				split_offset_right -= event.relative.x
			else:
				return
			queue_redraw()
			queue_sort()
		else:
			if event.position.x > split_offset_left and event.position.x < split_offset_left + splitter_width:
				splitter_focus = 1
				queue_redraw()
			elif event.position.x > size.x - split_offset_right - splitter_width and event.position.x < size.x - split_offset_right:
				splitter_focus = 2
				queue_redraw()
			else:
				splitter_focus = 0
				queue_redraw()
				
			if splitter_focus:
				mouse_default_cursor_shape = 10
			else:
				mouse_default_cursor_shape = 0
		
	
	if e is InputEventMouseButton:
		var event: = e as InputEventMouseButton
		if event.pressed and splitter_focus:
			dragging = true
		if not event.pressed:
			dragging = false

func _get_configuration_warnings() -> PackedStringArray:
	var warns: = PackedStringArray()
	if get_child_count() != 3:
		warns.append("Split3Container works only with 3 children.")
	if not splitter_stylebox:
		warns.append("Splitter Stylebox is null.")
	return warns
