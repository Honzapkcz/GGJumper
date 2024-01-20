extends Node

@export var input_id: String
@export var input_group: String
@export var output_id: String
@export var output_group: String


func _ready():
	Global.latch.connect(on_latch)


func on_latch(on: bool, id: String, group: String):
	if id != input_id or group != input_group:
		return
	Global.latch.emit(not on, output_id, output_group)
