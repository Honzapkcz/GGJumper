@tool
extends Container
## F**king hell
## Might refractor later
class_name HSplitXContainer

var split_focus: int
var dragging: bool
var i: int
@export var split_width: float = 5:
	set(value):
		split_width = value
		_notification(NOTIFICATION_CHILD_ORDER_CHANGED)
@export var split_stylebox: StyleBoxLine:
	set(value):
		split_stylebox = value
		update_configuration_warnings()
@export var split_offset: PackedFloat32Array
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
		i = 0
		for c in get_children():
			if not c is Control:
				continue
			fit_child_in_rect(c, Rect2(split_offset[i], 0, split_offset[i + 1] - split_offset[i] - split_width, size.y))
			i += 1
	elif what == NOTIFICATION_DRAW:
		if not split_stylebox:
			return
		if split_focus < 0:
			return
		draw_style_box(split_stylebox, Rect2(split_offset[split_focus - 1] - split_width / 2 - split_stylebox.thickness / 2, 0, split_width, size.y))
	elif what == NOTIFICATION_CHILD_ORDER_CHANGED:
		i = 0
		for c in get_children():
			if not c is Control:
				continue
			i += 1
		split_offset.resize(i)
		split_offset[i] = size.x
		queue_sort()
		queue_redraw()
		update_configuration_warnings()

## Cover your eyes please
func _gui_input(e: InputEvent) -> void:
	if e is InputEventMouseMotion:
		var event: = e as InputEventMouseMotion
		
		if dragging:
			# Would drag my balls only to refractor this mess
			if split_focus == 1 and split_offset_left - event.relative.x > 0 and event.relative.x < 0 or size.x - split_offset_left - split_offset_right - 2 * split_width - event.relative.x > 2:
				split_offset_left += event.relative.x
			elif split_focus == 2 and split_offset_right + event.relative.x < size.x and event.relative.x > 0 or size.x - split_offset_left - split_offset_right - 2 * split_width + event.relative.x > 2:
				split_offset_right -= event.relative.x
			else:
				return
			queue_redraw()
			queue_sort()
			return
		
		split_focus = -1
		for i in range(split_offset.size()):
			if event.position.x > split_offset[i] and event.position.x < split_offset[i] + split_width:
				split_focus = i
				queue_redraw()
				break
			
		mouse_default_cursor_shape = 10 if split_focus >= 0 else 0
		
	
	if e is InputEventMouseButton:
		var event: = e as InputEventMouseButton
		if event.pressed and split_focus >= 0:
			dragging = true
		if not event.pressed:
			dragging = false

func _get_configuration_warnings() -> PackedStringArray:
	var warns: = PackedStringArray()
	if not split_stylebox:
		warns.append("Splitter Stylebox is null.")
	return warns
