extends Node

@export var object_id: String
@export var output_id: String
@export var clock_interval_ms: int
@export var active: bool

var clock: bool

func _ready():
	Global.latch.connect(on_latch)


func start_clock():
	if not active:
		return
	
	clock = true
	while active:
		await get_tree().create_timer(clock_interval_ms / 1000.0).timeout
		clock = !clock
		Global.latch.emit(clock, output_id)
	

func on_latch(on: bool, id: String):
	if id != object_id:
		return
	active = on
	start_clock()
