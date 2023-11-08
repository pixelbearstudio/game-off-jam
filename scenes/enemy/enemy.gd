class_name Enemy
extends CharacterBody2D

const GRAVITY: int = 1000
const MAX_H_SPEED: int = 140
const H_ACCELERATION: int = 2000
const MOVE_LERP_FACTOR: int = -50

var move_vector: Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:

	velocity.x += move_vector.x * H_ACCELERATION * delta
	if move_vector.x == 0: velocity.x = lerpf(0, velocity.x, pow(2, MOVE_LERP_FACTOR * delta))
	
	velocity.x = clampf(velocity.x, -MAX_H_SPEED, MAX_H_SPEED)
	velocity.y += GRAVITY * delta
	
	update_enemy_direction()
	move_and_slide()

func update_enemy_direction() -> void:
	if is_on_wall():
		velocity.x *= -1
		move_vector.x *= -1
