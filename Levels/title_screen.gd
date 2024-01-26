extends Control


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")


func _on_multiplayer_button_pressed():
	get_tree().change_scene_to_file("res://Levels/multiplayer_screen.tscn")
