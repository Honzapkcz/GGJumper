extends Area2D

var speedrun: bool

func _ready() -> void:
	await get_tree().physics_frame
	if not Global.timer_paused:
		$"../Lever".latch(true)
		speedrun = true
	Global.timer_paused = true
	await get_tree().physics_frame
	Global.latch.connect(on_latch)

func _exit_tree() -> void:
	Global.timer_paused = not speedrun
	Global.timer = 0

func on_latch(on: bool, id: String):
	if not id == "speedrun":
		return
	speedrun = on
	Global.timer = 0.0001 if on else 0

func _on_body_entered(body):
	if body is Player:
		get_tree().quit()
