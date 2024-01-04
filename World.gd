extends Node2D

var level := 0
var res_pos := Vector2.ZERO

var in_editor: bool:
	set(value):
		$Player/CanvasLayer.visible = not value
		$Player.state = $Player.DISABLED
		in_editor = value

func _ready():
	res_pos = $Player.position
	Global.respawn.connect(respawn)
	Global.checkpoint.connect(checkpoint)

func respawn():
	$Player.position = res_pos

func checkpoint(pos: Vector2, lvl: int):
	if lvl > level:
		res_pos = pos

func _on_button_pressed():
	Transition.change_scene("res://Worlds/Lobby.tscn")
