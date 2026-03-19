extends Control
class_name SceneNav

# 返回主菜单时使用的场景路径
const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"

# 子场景里的返回按钮统一走这里
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
