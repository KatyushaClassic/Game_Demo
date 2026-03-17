extends Resource
class_name WeaponGroupData

# 武器组编号
@export var group_id: int = 1
# 武器 ID 列表
@export var weapon_ids: Array[String] = []
# 是否自动开火
@export var auto_fire: bool = false
# 是否允许玩家控制
@export var player_controllable: bool = true
