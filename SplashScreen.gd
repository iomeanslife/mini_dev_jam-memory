extends Node2D

#onready var resourcePreloader = $ResourcePreloader

func _ready():
	var mainMenu = preload("res://MainMenu.tscn")
	get_tree().change_scene_to(mainMenu)
