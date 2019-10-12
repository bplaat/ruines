extends Node2D

func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/intro_scene.tscn")

func _on_help_button_pressed():
	get_tree().change_scene("res://scenes/help_scene.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
