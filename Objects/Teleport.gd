extends Area2D

## Evaluated [i]First[/i][br]
## If non-empty, changes world to [b]scene_destination[/b]
@export_file("*.tscn") var scene_destination: String
## Evaluated [i]Second[/i][br]
## If non-empty, sets player positon to [b]node_position_destination[/b]'s position
@export var position_destination: Vector2
## Evaluated only when [b]node_position_destination[/b] is [i]empty[/i][br]
## If non-empty, changes player position to [b]position_destination[/b]
@export_node_path("CanvasItem") var node_position_destination: NodePath

var can_teleport: bool = false
var last_body: Object

func _physics_process(_delta):
	if Input.is_action_just_pressed("Select") and can_teleport:
		if scene_destination:
			Transition.change_scene(scene_destination)
			await get_tree().create_timer(Transition.speed + 0.1).timeout
		if node_position_destination:
			last_body.position = get_node(node_position_destination).position
		else:
			last_body.position = position_destination
	

func _on_body_entered(body):
	if body is Player:
		can_teleport = true
		last_body = body
		get_tree().create_tween().tween_property($Label, "modulate", Color(1, 1, 1, 1), 0.5)

func _on_body_exited(body):
	if body is Player:
		can_teleport = false
		get_tree().create_tween().tween_property($Label, "modulate", Color(1, 1, 1, 0), 0.5)
