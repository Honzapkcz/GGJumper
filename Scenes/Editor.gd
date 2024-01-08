extends MarginContainer


enum {
	TYPE_NIL = 0,
	TYPE_BOOL = 1,
	TYPE_INT = 2,
	TYPE_FLOAT = 3,
	TYPE_STRING = 4,
	TYPE_VECTOR2 = 5,
	TYPE_VECTOR2I = 6,
	TYPE_RECT2 = 7,
	TYPE_RECT2I = 8,
	TYPE_VECTOR3 = 9,
	TYPE_VECTOR3I = 10,
	TYPE_TRANSFORM2D = 11,
	TYPE_VECTOR4 = 12,
	TYPE_VECTOR4I = 13,
	TYPE_PLANE = 14,
	TYPE_QUATERNION = 15,
	TYPE_AABB = 16,
	TYPE_BASIS = 17,
	TYPE_TRANSFORM3D = 18,
	TYPE_PROJECTION = 19,
	TYPE_COLOR = 20,
	TYPE_STRING_NAME = 21,
	TYPE_NODE_PATH = 22,
	TYPE_RID = 23,
	TYPE_OBJECT = 24,
	TYPE_CALLABLE = 25,
	TYPE_SIGNAL = 26,
	TYPE_DICTIONARY = 27,
	TYPE_ARRAY = 28,
	TYPE_PACKED_BYTE_ARRAY = 29,
	TYPE_PACKED_INT32_ARRAY = 30,
	TYPE_PACKED_INT64_ARRAY = 31,
	TYPE_PACKED_FLOAT32_ARRAY = 32,
	TYPE_PACKED_FLOAT64_ARRAY = 33,
	TYPE_PACKED_STRING_ARRAY = 34,
	TYPE_PACKED_VECTOR2_ARRAY = 35,
	TYPE_PACKED_VECTOR3_ARRAY = 36,
	TYPE_PACKED_COLOR_ARRAY = 37,
	TYPE_MAX = 38,
}

@onready var graphEdit: GraphEdit = $LSplit/RSplit/VSplit/GraphEdit
@onready var world: Node2D = $LSplit/RSplit/VSplit/VPort/SVPort/World
@onready var camera: Camera2D = $LSplit/RSplit/VSplit/VPort/SVPort/Camera2D
@onready var lpanel: Panel = $LSplit/LPanel
@onready var rpanel: Panel = $LSplit/RSplit/RPanel
@onready var tree: Tree = $LSplit/LPanel/Margin/VBox/Tree
@onready var grid: GridContainer = $LSplit/RSplit/RPanel/Margin/Grid

@export var node_prefix: String = "res://GraphNode/"
@export var graph_nodes: Dictionary = {
	"Clock": "ClockNode.tscn",
	"Boolean": "BooleanConstNode.tscn",
	"Integer": "IntegerConstNode.tscn",
}
var registered_params: Array[GraphNode]
var l_panel_size: float

func _ready():
	world.in_editor = true
	camera.make_current()
	l_panel_size = lpanel.size.x
	
	#lpanel.custom_minimum_size.x = lpanel.size.x
	
	var butt: MenuButton = MenuButton.new()
	butt.text = "Add Node..."
	butt.name = "MyButt"
	for i in graph_nodes:
		butt.get_popup().add_item(i)
	butt.get_popup().index_pressed.connect(on_hbox_button_pressed)
	var hbox: HBoxContainer = graphEdit.get_menu_hbox()
	hbox.add_child(butt)
	hbox.move_child(hbox.get_node("MyButt"), 0)
	
	for i in range(TYPE_MAX):
		graphEdit.add_valid_connection_type(i + 64, i)
	
	update_properties(Label.new())

func on_hbox_button_pressed(index: int):
	var node: GraphNode = load(node_prefix + graph_nodes.values()[index]).instantiate()
	if node.get_meta("params"):
		registered_params.append(node)
	node.position_offset = graphEdit.scroll_offset + graphEdit.size / 3
	graphEdit.add_child(node)

func on_textedit_popup(value: String):
	var textpopup: Window = load("res://GraphNode/TextEditPopup.tscn").instantiate()
	var textedit: TextEdit = grid.get_node(value + "/TextEdit")
	textpopup.on_update.connect(on_textedit_popup_update.bind(textedit))
	add_child(textpopup)
	textedit.text_changed.connect(textpopup.change.bind(textedit))
	textpopup.init(textedit.text, textedit.get_node("..").name)

func on_textedit_popup_update(value: String, node: TextEdit):
	node.text = value
	
func update_properties(object: Object):
	for i in grid.get_children():
		grid.remove_child(i)
		i.queue_free()
	var obj_list: Array[Dictionary] = object.get_property_list()
	# i = {name: String, class_name: StringName, type: int}
	for i in obj_list:
		var label: Label = Label.new()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		match i.type:
			TYPE_BOOL:
				label.name = i.name + "Label"
				label.text = i.name.capitalize()
				grid.add_child(label)
				var checkbox: CheckBox = CheckBox.new()
				checkbox.name = i.name
				checkbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				checkbox.button_pressed = object[i.name]
				grid.add_child(checkbox)
			TYPE_INT:
				label.name = i.name + "Label"
				label.text = i.name.capitalize()
				grid.add_child(label)
			TYPE_FLOAT:
				label.name = i.name + "Label"
				label.text = i.name.capitalize()
				grid.add_child(label)
			TYPE_STRING:
				pass
			TYPE_VECTOR2:
				pass

func _on_graph_edit_delete_nodes_request(nodes: Array[StringName]):
	for i in nodes:
		var node = graphEdit.get_node(NodePath(i))
		print("queue delete: ", node)
		if node in registered_params:
			registered_params.erase(node)
			print("unregister: ", node)
		graphEdit.remove_child(node)
		node.queue_free()
		print("deleted: ", node)

func _on_graph_edit_copy_nodes_request():
	pass # Replace with function body.


func _on_graph_edit_paste_nodes_request():
	pass # Replace with function body.


func _on_graph_edit_connection_request(from_node: String, from_port: int, to_node: String, to_port: int):
	graphEdit.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node: String, from_port: int, to_node: String, to_port: int):
	graphEdit.disconnect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_node_selected(node):
	print("selected")


func _on_graph_edit_node_deselected(node):
	print("deselected")


func _on_graph_edit_gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not event.button_index == MOUSE_BUTTON_LEFT or event.pressed:
		return
	for i in registered_params:
		print(i.name)


func _on_l_panel_resized():
	#rpanel.size_flags_stretch_ratio = lpanel.size.x / rpanel.size.x if lpanel.size.x > rpanel.size.x else lpanel.size.x / rpanel.size.x
	pass


func _on_l_split_dragged(offset: int):
	offset = offset if offset else 1
	#rpanel.size_flags_stretch_ratio *= offset
	print("dragged: ", rpanel.size_flags_stretch_ratio)
	
