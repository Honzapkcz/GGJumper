extends CanvasGroup

@export var wiggle: Vector2
@export var transition: TransitionType = TransitionType.TRANS_CUBIC
@export var easing: EaseType = EaseType.EASE_IN_OUT
@export var clock_multiplier: int = 1
@export var delay: float

enum TransitionType {
	TRANS_LINEAR = 0,
	TRANS_SINE = 1,
	TRANS_QUINT = 2,
	TRANS_QUART = 3,
	TRANS_QUAD = 4,
	TRANS_EXPO = 5,
	TRANS_ELASTIC = 6,
	TRANS_CUBIC = 7,
	TRANS_CIRC = 8,
	TRANS_BOUNCE = 9,
	TRANS_BACK = 10,
	TRANS_SPRING = 11,
}
enum  EaseType {
	EASE_IN = 0,
	EASE_OUT = 1,
	EASE_IN_OUT = 2,
	EASE_OUT_IN = 3,
}
# These two arrays are there beacuse set_trans() & set_ease() needs native
# enums whitch i cannot acces so i had to recreate it using arrays
var otrans: Array = [
	Tween.TRANS_LINEAR,
	Tween.TRANS_SINE,
	Tween.TRANS_QUINT,
	Tween.TRANS_QUART,
	Tween.TRANS_QUAD,
	Tween.TRANS_EXPO,
	Tween.TRANS_ELASTIC,
	Tween.TRANS_CUBIC,
	Tween.TRANS_CIRC,
	Tween.TRANS_BOUNCE,
	Tween.TRANS_BACK,
	Tween.TRANS_SPRING,
]
var oease: Array = [
	Tween.EASE_IN,
	Tween.EASE_OUT,
	Tween.EASE_IN_OUT,
	Tween.EASE_OUT_IN,
]

func _ready():
	Global.animate.connect(on_animate)

func on_animate(clock: int):
	if clock % clock_multiplier != 0:
		return
	get_tree().create_tween().tween_property(self, "position",
		wiggle if clock % (2 * clock_multiplier) else -wiggle,
		Global.anim_speed * clock_multiplier
		).set_trans(otrans[transition]
		).set_ease(oease[easing]
		).set_delay(delay)
