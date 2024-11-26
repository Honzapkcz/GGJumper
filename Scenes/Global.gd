extends Node

@export var clock_time: float
@export var anim_speed: float

signal respawn()
signal checkpoint(pos: Vector2, level: int)
signal latch(on: bool, id: String)
signal pick(item: String)
signal drop(item: String)
signal animate(clock: int)

var clock_value: int = 0

func _ready():
	while true:
		await get_tree().create_timer(clock_time).timeout
		clock_value += 1
		animate.emit(clock_value)
	
