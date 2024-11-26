extends Node

@export var input_id: String
@export var output_id: String

func _ready():
	Global.latch.connect(on_latch)

func on_latch(on: bool, id: String):
	if id != input_id:
		return
	Global.latch.emit(not on, output_id)
