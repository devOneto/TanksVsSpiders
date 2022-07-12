extends Node2D


onready var level_one_button = $Level01Button
onready var level_two_button = $Level02Button
onready var exit_button = $ExitButton

func _ready():
	level_one_button.connect("pressed", self, "play_level_01")
	level_two_button.connect("pressed", self, "play_level_02")
	exit_button.connect("pressed", self, "quit")

func play_level_01():
	get_tree().change_scene("res://scenes/Levels/Level_01.tscn")
	pass

func play_level_02():
	get_tree().change_scene("res://scenes/Levels/Level_02.tscn")
	pass

func quit():
	get_tree().quit()
	pass

