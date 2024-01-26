extends Node

@export var input1_id: String
@export var input1_group: String
@export var input2_id: String
@export var input2_group: String
@export var output_id: String
@export var output_group: String

var input1: bool
var input2: bool
var output: bool

func _ready():
	Global.latch.connect(on_latch)


func on_latch(on: bool, id: String, group: String):
	if id != input1_id and (group != input1_group or group.is_empty()) and id != input2_id and (group != input2_group or group.is_empty()):
		return
	if id == input1_id or (group == input1_group and not group.is_empty()):
		input1 = on
	if id == input2_id or (group == input2_group and not group.is_empty()):
		input2 = on
	if output != (input1 != input2):
		output = input1 != input2
		Global.latch.emit(output, output_id, output_group)
