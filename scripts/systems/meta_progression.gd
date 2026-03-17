extends Node
class_name MetaProgression

var score_currency: int = 0
var unlock_level: int = 1
var unlocked_block_ids: Array[String] = []
var unlocked_core_ids: Array[String] = []

func add_run_score(score: int) -> void:
	score_currency += max(score, 0)

func can_level_up(cost: int) -> bool:
	return score_currency >= cost

func level_up(cost: int, reward_blocks: Array[String], reward_cores: Array[String]) -> bool:
	if not can_level_up(cost):
		return false
	score_currency -= cost
	unlock_level += 1
	for id in reward_blocks:
		if id not in unlocked_block_ids:
			unlocked_block_ids.append(id)
	for id in reward_cores:
		if id not in unlocked_core_ids:
			unlocked_core_ids.append(id)
	return true
