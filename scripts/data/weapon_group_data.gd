extends Resource
class_name WeaponGroupData

# 武器组唯一编号（例如 1,2,3）
@export var group_id: int = 1

# 该组内包含的武器 ID 列表
@export var weapon_ids: Array[String] = []

# 是否自动开火（给 AI 或自动策略使用）
@export var auto_fire: bool = false

# 是否允许玩家手动控制该组（可用于后续扩展）
@export var player_controllable: bool = true
