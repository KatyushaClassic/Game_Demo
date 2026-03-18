extends Control
class_name MainMenu

# 场景路径常量
const SYSTEMS_SCENE := "res://scenes/systems_scene.tscn"
const MAP_SCENE := "res://scenes/map_scene.tscn"
const BATTLE_SCENE := "res://scenes/battle_scene.tscn"
const META_SCENE := "res://scenes/meta_scene.tscn"

func _on_open_systems_pressed() -> void:
	get_tree().change_scene_to_file(SYSTEMS_SCENE)

func _on_open_map_pressed() -> void:
	get_tree().change_scene_to_file(MAP_SCENE)

func _on_open_battle_pressed() -> void:
	get_tree().change_scene_to_file(BATTLE_SCENE)

func _on_open_meta_pressed() -> void:
	get_tree().change_scene_to_file(META_SCENE)
