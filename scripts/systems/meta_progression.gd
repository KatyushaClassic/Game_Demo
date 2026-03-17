extends Node
class_name MetaProgression

var score_currency: int = 0

var unlock_level: int = 1

var unlocked_block_ids: Array[String] = []
var unlocked_core_ids: Array[String] = []

var level_table: Dictionary = {}

func set_level_table(level_list: Array[MetaLevelData]) -> void:
	level_table.clear()
	for info in level_list:
		level_table[info.level] = info

func add_run_score(score: int) -> void:
	score_currency += max(score, 0)

func can_level_up() -> bool:
	var target_level := unlock_level + 1
	var info: MetaLevelData = level_table.get(target_level)
	if info == null:
		return false
	return score_currency >= info.upgrade_cost

func level_up() -> bool:
	if not can_level_up():
		return false

	var target_level := unlock_level + 1
	var info: MetaLevelData = level_table[target_level]

	score_currency -= info.upgrade_cost
	unlock_level = target_level

	for id in info.reward_block_ids:
		if id not in unlocked_block_ids:
			unlocked_block_ids.append(id)

	for id in info.reward_core_ids:
		if id not in unlocked_core_ids:
			unlocked_core_ids.append(id)

	return true
