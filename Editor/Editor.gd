extends Control

@export var tree: Tree
@export var graph: GraphEdit
@export var docktab: TabContainer
@export var atlaslist: ItemList
@export var tilelist: ItemList
@export var tooltab: TabContainer
@export var objectlist: ItemList
@export var logiclist: ItemList
@export var tileset: TileSet
@export var sceneroot: Node2D
@export var objects: Array[PackedScene]
@export var elements: Array[PackedScene]

func _on_scene_mode_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		return
	docktab.current_tab = 0
	tooltab.current_tab = 0


func _on_terrain_mode_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		return
	docktab.current_tab = 1
	tooltab.current_tab = -1


func _on_script_mode_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		return
	docktab.current_tab = 0
	tooltab.current_tab = 1


func _on_objects_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	pass # Replace with function body.


func _on_logic_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	pass # Replace with function body.


func _on_tree_multi_selected(item: TreeItem, column: int, selected: bool) -> void:
	pass # Replace with function body.


func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	pass # Replace with function body.


func _on_graph_edit_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	pass # Replace with function body.


func _on_atlas_list_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_tileset_list_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_world_index_pressed(index: int) -> void:
	match index:
		0:
			pass # New
		1:
			pass # Open
		2:
			pass # Save As
		3:
			pass # Save
		4:
			pass # Exit
		5:
			pass # Recent


func _on_view_index_pressed(index: int) -> void:
	pass # Replace with function body.


func _on_help_index_pressed(index: int) -> void:
	pass # Replace with function body.
