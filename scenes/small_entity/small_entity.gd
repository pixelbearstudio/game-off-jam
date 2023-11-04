class_name SmallEntity
extends Node2D

const interact_input: String = "interact"

@export var entity_scene: PackedScene

var is_inside_area: bool = false

@onready var interact_node: Area2D = $InteractArea as Area2D


func _ready():
	interact_node.area_entered.connect(on_interact_entered)
	interact_node.area_exited.connect(on_interact_exited)


func _process(_delta: float) -> void:
	if is_inside_area and Input.is_action_just_pressed(interact_input):
		is_inside_area = false
		get_tree().change_scene_to_packed(entity_scene)


func on_interact_entered(_area: Area2D) -> void:
	is_inside_area = true


func on_interact_exited(_area: Area2D) -> void:
	is_inside_area = false
