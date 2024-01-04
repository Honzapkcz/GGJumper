extends Node

@export var object_id: String
@export var object_group: String
@export var invoke_id: String
@export var invoke_group: String
@export var clock_interval_ms: int
@export var repetitive: bool
@export var use_animate_clock: bool
@export var active: bool

func _ready():
	Global.latch.connect(on_latch)
	Global.animate.connect(on_animate)

func _process(delta):
	if active or not repetitive or use_animate_clock:
		return
	active = true
	await get_tree().create_timer(clock_interval_ms / 1000).timeout
	

func on_latch(on: bool, id: String, group: String):
	pass

func on_animate(clock: int):
	pass
