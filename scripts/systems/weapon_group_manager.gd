extends Node
class_name WeaponGroupManager

signal group_fired(group_id: int)

var groups: Dictionary = {}
var active_group: int = 1

func set_group(group_id: int, weapon_ids: Array[String], auto_fire: bool) -> void:
	groups[group_id] = {
		"weapon_ids": weapon_ids,
		"auto_fire": auto_fire
	}

func switch_group(group_id: int) -> void:
	if groups.has(group_id):
		active_group = group_id

func set_auto_fire(group_id: int, enabled: bool) -> void:
	if groups.has(group_id):
		groups[group_id]["auto_fire"] = enabled

func request_player_fire() -> void:
	if not groups.has(active_group):
		return
	emit_signal("group_fired", active_group)

func tick_ai_auto_fire(should_fire: bool) -> Array[int]:
	var fired_groups: Array[int] = []
	if not should_fire:
		return fired_groups
	for id in groups.keys():
		if id == active_group:
			continue
		if groups[id]["auto_fire"]:
			fired_groups.append(id)
	return fired_groups
