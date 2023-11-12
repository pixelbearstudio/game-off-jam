class_name Enemy
extends CharacterBody2D

enum EnemyForm {
	PEACEFUL,
	HOSTILE
}
enum EnemyStates {
	WALKING,
	FALLING,
	ENRAGED,
	DEAD,
}

const GRAVITY: int = 1000
const MAX_H_SPEED: int = 100
const H_ACCELERATION: int = 2000
const MOVE_LERP_FACTOR: int = -50

var move_vector: Vector2
var current_state: EnemyStates = EnemyStates.WALKING

@export var initial_form: EnemyForm = EnemyForm.PEACEFUL

@onready var is_falling = false

func _ready() -> void:
	var player = _get_player_node()
	move_vector = Vector2.RIGHT if player != null and player.position.x > self.position.x else Vector2.LEFT
	
	

func _process(delta: float) -> void:

	velocity.x += move_vector.x * H_ACCELERATION * delta
	if move_vector.x == 0: velocity.x = lerpf(0, velocity.x, pow(2, MOVE_LERP_FACTOR * delta))
	
	velocity.x = clampf(velocity.x, -MAX_H_SPEED, MAX_H_SPEED)
	velocity.y += GRAVITY * delta
	
	current_state = EnemyStates.FALLING if !is_on_floor() else current_state
	
	_update_enemy_direction()
	move_and_slide()

func _get_player_node() -> Node2D:
	return get_node("/root/PlaceholderLevel/PlayerRoot/Player")
	
func _update_enemy_direction() -> void:		
	if (is_on_wall()):
		velocity.x *= -1
		move_vector.x *= -1
