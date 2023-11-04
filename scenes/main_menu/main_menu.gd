class_name MainMenu
extends CanvasLayer

const FirstScene: PackedScene = preload("res://scenes/placeholder_level/placeholder_level.tscn")

@onready var play_button_node: AnimatedButton = (
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
) as AnimatedButton
@onready var options_button_node: AnimatedButton = (
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HowToButton
) as AnimatedButton
@onready var quit_button_node: AnimatedButton = (
	$MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton
) as AnimatedButton


func _ready() -> void:
	play_button_node.pressed.connect(on_play_pressed)
	quit_button_node.pressed.connect(on_quit_pressed)


func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(FirstScene)


func on_quit_pressed() -> void:
	get_tree().quit()
