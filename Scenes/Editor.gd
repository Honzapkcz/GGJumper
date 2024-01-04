extends MarginContainer

@onready var graphEdit: GraphEdit = $LSplit/RSplit/VSplit/GraphEdit
@onready var world: Node2D = $LSplit/RSplit/VSplit/VPort/SVPort/World
@onready var camera: Camera2D = $LSplit/RSplit/VSplit/VPort/SVPort/Camera2D
@export var node_prefix: String = "res://GraphNode/"
@export var nodes: Dictionary = {
	"Clock": "ClockNode.tscn",
	"Boolean": "BooleanConstNode.tscn",
	"Integer": "IntegerConstNode.tscn",
}

# NI: Not Implemented (Yet)
enum I {
	NUL = 00,
	INT = 01,
	FLT = 02,
	BOL = 03,
	STR = 04,
	SIG = 05,
	CAL = 06, #NI
	CLR = 07,
	VC2 = 08,
	VC3 = 09, #NI
	VC4 = 10, #NI
	ARR = 11, #NI
	DCT = 12, #NI
	OBJ = 32, #NI
	SCN = 33,
	TXR = 34, #NI
	
}
enum O {
	NUL = 16,
	INT = 17,
	FLT = 18,
	BOL = 19,
	STR = 20,
	SIG = 21,
	CAL = 22, #NI
	CLR = 23,
	VC2 = 24,
	VC3 = 25, #NI
	VC4 = 26, #NI
	ARR = 27, #NI
	DCT = 28, #NI
	OBJ = 48, #NI
	SCN = 49,
	TXR = 50, #NI
}


func _ready():
	world.in_editor = true
	
	var butt: MenuButton = MenuButton.new()
	butt.text = "Add Node..."
	butt.name = "MyButt"
	for i in nodes:
		butt.get_popup().add_item(i)
	butt.get_popup().index_pressed.connect(on_hbox_button_pressed)
	var hbox: HBoxContainer = graphEdit.get_menu_hbox()
	hbox.add_child(butt)
	hbox.move_child(hbox.get_node("MyButt"), 0)
	
	for i in I:
		graphEdit.add_valid_connection_type(O[i], I[i])

func on_hbox_button_pressed(index: int):
	graphEdit.add_child(load(node_prefix + nodes.values()[index]).instantiate())


func _on_graph_edit_copy_nodes_request():
	pass # Replace with function body.


func _on_graph_edit_paste_nodes_request():
	pass # Replace with function body.


func _on_graph_edit_connection_request(from_node: String, from_port: int, to_node: String, to_port: int):
	graphEdit.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_edit_disconnection_request(from_node: String, from_port: int, to_node: String, to_port: int):
	pass
