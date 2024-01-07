extends MarginContainer

enum I {
	NUL = 00, INT = 01, FLT = 02, BOL = 03,
	STR = 04, SIG = 05, CAL = 06, CLR = 07,
	VC2 = 08, VC3 = 09, VC4 = 10, ARR = 11,
	DCT = 12, OBJ = 32, SCN = 33, TXR = 34,
	
}
enum O {
	NUL = 16, INT = 17, FLT = 18, BOL = 19,
	STR = 20, SIG = 21, CAL = 22, CLR = 23,
	VC2 = 24, VC3 = 25, VC4 = 26, ARR = 27,
	DCT = 28, OBJ = 48, SCN = 49, TXR = 50,
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
	
	for i in I:
		graphEdit.add_valid_connection_type(O[i], I[i])

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

func on_textedit_popup_update(value: String, node: Control):
	node.text = value

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
	
