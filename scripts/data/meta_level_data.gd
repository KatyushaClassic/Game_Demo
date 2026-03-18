extends Resource
class_name MetaLevelData

# 目标等级
@export var level: int = 1
# 升级消耗分数
@export var upgrade_cost: int = 100
# 升级解锁方块
@export var reward_block_ids: Array[String] = []
# 升级解锁核心
@export var reward_core_ids: Array[String] = []
