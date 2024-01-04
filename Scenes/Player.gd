extends CharacterBody2D
class_name Player

const SPEED = 30000.0
const JUMP_VELOCITY = -400.0
const FRICTION = 20
const FRICTION2 = 30
const EYE_OFFSET = 48
@onready var eye1_pos = $Eye1.position
@onready var eye2_pos = $Eye2.position

enum {
	WALK,
	CLIMB,
	DISABLED,
}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = WALK

func _physics_process(delta):
	# Add the gravity.
	match state:
		WALK:
			walk(delta)
		CLIMB:
			climb(delta)
	
func walk(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED * delta, FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION2)
	$Eye1.position = eye1_pos + velocity / EYE_OFFSET
	$Eye2.position = eye2_pos + velocity / EYE_OFFSET

	move_and_slide()

func climb(delta):
	velocity.x = move_toward(velocity.x, Input.get_axis("Left", "Right") * SPEED * delta, FRICTION)
	velocity.y = move_toward(velocity.y, Input.get_axis("Jump", "Down") * SPEED * delta, FRICTION)
	
	$Eye1.position = eye1_pos + velocity / EYE_OFFSET
	$Eye2.position = eye2_pos + velocity / EYE_OFFSET
	
	move_and_slide()

func _on_area_2d_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	Global.respawn.emit()


func _on_button_pressed():
	Transition.change_scene("res://Worlds/Lobby.tscn")


func _on_ladder_area_2d_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	state = CLIMB


func _on_ladder_area_2d_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	if not $LadderArea2D.has_overlapping_bodies():
		state = WALK
