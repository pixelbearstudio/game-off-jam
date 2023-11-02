class_name Player
extends CharacterBody2D

const GRAVITY: int = 1000
const MAX_H_SPEED: int = 140
const H_ACCELERATION: int = 2000
const JUMP_SPEED: int = 320
const JUMP_TER_MULT: int = 4
const MOVE_LERP_FACTOR: int = -50

const INPUTS: Dictionary = {
	move_right = "move_right",
	move_left = "move_left",
	jump = "jump"
}

var has_double_jump: bool = false

@onready var coyote_timer_node: Timer = $CoyoteTimer as Timer

func _process(delta: float) -> void:
	var move_vector: Vector2 = get_movement_vector()

	velocity.x += move_vector.x * H_ACCELERATION * delta
	if move_vector.x == 0: velocity.x = lerpf(0, velocity.x, pow(2, MOVE_LERP_FACTOR * delta))
	
	velocity.x = clampf(velocity.x, -MAX_H_SPEED, MAX_H_SPEED)
	
	var can_jump: bool = is_on_floor() or has_double_jump or coyote_timer_node.is_stopped()
	
	if move_vector.y < 0 and can_jump:
		velocity.y = move_vector.y * JUMP_SPEED
		if not is_on_floor() and coyote_timer_node.is_stopped(): has_double_jump = false
		coyote_timer_node.stop()
	
	if velocity.y < 0 and not Input.is_action_pressed(INPUTS.jump):
		velocity.y += GRAVITY * JUMP_TER_MULT * delta
	else:
		velocity.y += GRAVITY * delta
	
	var was_on_floor: bool = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor(): coyote_timer_node.start()
	
	if is_on_floor():
		has_double_jump = true


func get_movement_vector() -> Vector2:
	var move_vector: Vector2 = Vector2.ZERO
	var input_right: float = Input.get_action_strength(INPUTS.move_right)
	var input_left: float = Input.get_action_strength(INPUTS.move_left)

	move_vector.x = input_right - input_left
	move_vector.y = -1 if Input.is_action_just_pressed(INPUTS.jump) else 0
	return move_vector
