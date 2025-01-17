extends Node

@export var clock_time: float
@export var anim_speed: float

@warning_ignore("unused_signal") signal respawn()
@warning_ignore("unused_signal") signal checkpoint(pos: Vector2, level: int)
@warning_ignore("unused_signal") signal latch(on: bool, id: String)
@warning_ignore("unused_signal") signal pick(item: String)
@warning_ignore("unused_signal") signal drop(item: String)
@warning_ignore("unused_signal") signal animate(clock: int)

var clock_value: int = 0
var timer: float = 0
var timer_paused: bool = true

func _ready():
	while true:
		await get_tree().create_timer(clock_time).timeout
		clock_value += 1
		animate.emit(clock_value)
	

func _process(delta: float) -> void:
	if not timer_paused:
		timer += delta
