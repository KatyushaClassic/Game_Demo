extends Node
class_name MetaProgression

# 当前可用评分货币
var score_currency: int = 0

# 当前局外等级
var unlock_level: int = 1

# 已解锁内容（可存档）
var unlocked_block_ids: Array[String] = []
var unlocked_core_ids: Array[String] = []

# 等级配置表：key=level, value=MetaLevelData
var level_table: Dictionary = {}

# 装载等级资源配置
func set_level_table(level_list: Array[MetaLevelData]) -> void:
	level_table.clear()
	for info in level_list:
		level_table[info.level] = info

# 结算一局后加分
func add_run_score(score: int) -> void:
	score_currency += max(score, 0)

# 是否可升级到下一等级
func can_level_up() -> bool:
	var target_level := unlock_level + 1
	var info: MetaLevelData = level_table.get(target_level)
	if info == null:
		return false
	return score_currency >= info.upgrade_cost

# 执行升级并发放奖励
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
