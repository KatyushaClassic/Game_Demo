extends Resource
class_name MetaLevelData

# 局外成长等级（如 1,2,3...）
@export var level: int = 1

# 升到该等级需要的分数消耗
@export var upgrade_cost: int = 100

# 解锁方块列表
@export var reward_block_ids: Array[String] = []

# 解锁核心列表
@export var reward_core_ids: Array[String] = []
