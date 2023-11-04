class_name GameCamera
extends Camera2D

const POSITION_LERP_FACTOR: int = -15

func _process(delta: float) -> void:
	var target_position: Vector2 = get_player_position()
	global_position = global_position.lerp(target_position, pow(2, POSITION_LERP_FACTOR * delta))


func get_player_position() -> Vector2:
	var nodes: Array[Node] = get_tree().get_nodes_in_group("player")
	var target_position: Vector2 = Vector2.ZERO
	if nodes.size() > 0:
		var node: CharacterBody2D = nodes[0] as CharacterBody2D
		target_position = node.global_position

	return target_position
