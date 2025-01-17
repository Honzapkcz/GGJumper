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
@export var filepopup: FileDialog
@export var sceneroot: Node2D
@export var objects: Array[PackedScene]
@export var elements: Array[PackedScene]
@export var emptyworld: PackedScene

var level_path: String
# { "Node/Path" : EditorScriptObject, ... }
var level_wirings: Dictionary

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
			new_world()
		1:
			filepopup.popup_centered()
			filepopup.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			filepopup.title = "Open Scene"
		2:
			if level_path:
				save_world(level_path)
			filepopup.popup_centered()
			filepopup.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			filepopup.title = "Save Scene"
		3:
			filepopup.popup_centered()
			filepopup.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			filepopup.title = "Save Scene"
		4:
			get_tree().quit()
		5:
			pass # Recent


func _on_view_index_pressed(index: int) -> void:
	pass # Replace with function body.


func _on_help_index_pressed(index: int) -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	pass

func _ready() -> void:
	if not DirAccess.dir_exists_absolute("user://Levels"):
		DirAccess.make_dir_absolute("user://Levels")

func new_world() -> void:
	var level: = emptyworld.instantiate()
	sceneroot.replace_by(level)
	sceneroot = level
	sceneroot.process_mode = Node.PROCESS_MODE_PAUSABLE
	get_viewport().get_camera_2d().enabled = false
	get_tree().paused = true

func open_world(path: String) -> bool:
	var res: PackedScene = ResourceLoader.load(path, "PackedScene") as PackedScene
	if not res:
		return false
	var level: Node = res.instantiate()
	sceneroot.replace_by(level)
	sceneroot = level
	sceneroot.process_mode = Node.PROCESS_MODE_PAUSABLE
	get_viewport().get_camera_2d().enabled = false
	get_tree().paused = true
	return true

func save_world(path: String) -> bool:
	sceneroot.process_mode = Node.PROCESS_MODE_INHERIT
	get_viewport().get_camera_2d().enabled = true
	owner_nodes(sceneroot, sceneroot)
	var res: = PackedScene.new()
	res.pack(sceneroot)
	sceneroot.process_mode = Node.PROCESS_MODE_PAUSABLE
	get_viewport().get_camera_2d().enabled = false
	return not ResourceSaver.save(res, path)

func owner_nodes(node: Node, own: Node):
	for c in node.get_children():
		c.owner = own
		if c.get_child_count():
			owner_nodes(c, own)
