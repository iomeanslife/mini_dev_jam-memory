extends Node2D

func _on_Start_pressed():
	get_tree().change_scene("res://Board.tscn")


func _on_Info_pressed():
	get_tree().change_scene("res://Info.tscn")
