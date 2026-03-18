extends Control
class_name SceneNav

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
