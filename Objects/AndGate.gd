extends Node

@export var input1_id: String
@export var input2_id: String
@export var output_id: String

var input1: bool
var input2: bool
var output: bool

func _ready():
	Global.latch.connect(on_latch)


func on_latch(on: bool, id: String):
	if id != input1_id and id != input2_id:
		return
	if id == input1_id:
		input1 = on
	if id == input2_id:
		input2 = on
	if output != (input1 and input2):
		output = input1 and input2
		Global.latch.emit(output, output_id)
