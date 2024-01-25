extends CharacterBody2D
class_name Player

const SPEED = 30000
const JUMP_VELOCITY = -400
const FRICTION = 20
const FRICTION2 = 30
const EYE_OFFSET = 48
const PUSH_FORCE = 1000
@onready var eye1_pos: Vector2 = $Eye1.position
@onready var eye2_pos: Vector2 = $Eye2.position

enum {
	DISABLED,
	WALK,
	CLIMB,
	STAND,
}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var state: int = WALK
var vel: Vector2

func _physics_process(delta: float):
	# Add the gravity.
	match state:
		WALK:
			walk(delta)
		STAND:
			walk(delta)
		CLIMB:
			climb(delta)
	
	for i: int in range(get_slide_collision_count()):
		var c: KinematicCollision2D = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_force(-c.get_normal() * PUSH_FORCE)#, c.get_position())
	
func walk(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED * delta, FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION2)
	$Eye1.position = eye1_pos + velocity / EYE_OFFSET
	$Eye2.position = eye2_pos + velocity / EYE_OFFSET
	
	vel = velocity

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
