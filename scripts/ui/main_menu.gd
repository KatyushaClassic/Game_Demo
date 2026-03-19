extends Control
class_name MainMenu

# 主菜单里各个按钮要跳转到的场景路径
const SYSTEMS_SCENE := "res://scenes/systems_scene.tscn"
const MAP_SCENE := "res://scenes/map_scene.tscn"
const BATTLE_SCENE := "res://scenes/battle_scene.tscn"
const META_SCENE := "res://scenes/meta_scene.tscn"

# 点击“系统组装场景”按钮
func _on_open_systems_pressed() -> void:
	get_tree().change_scene_to_file(SYSTEMS_SCENE)

# 点击“地图场景”按钮
func _on_open_map_pressed() -> void:
	get_tree().change_scene_to_file(MAP_SCENE)

# 点击“战斗场景”按钮
func _on_open_battle_pressed() -> void:
	get_tree().change_scene_to_file(BATTLE_SCENE)

# 点击“局外成长场景”按钮
func _on_open_meta_pressed() -> void:
	get_tree().change_scene_to_file(META_SCENE)
