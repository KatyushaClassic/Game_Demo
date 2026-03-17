extends Resource
class_name FloorConfigData

# 层数索引（从 1 开始更符合设计文档习惯）
@export var floor_index: int = 1

# 地图行列
@export var rows: int = 12
@export var cols: int = 7

# 早期行禁止精英（例如前2行）
@export var elite_forbidden_rows: int = 2

# 房间权重配置，key=房间枚举名字符串，value=权重
# 示例：{"BATTLE": 4, "EVENT": 2, "SHOP": 1, "REPAIR": 1, "TREASURE": 1, "ELITE": 1}
@export var room_weights: Dictionary = {
	"BATTLE": 4,
	"EVENT": 2,
	"SHOP": 1,
	"REPAIR": 1,
	"TREASURE": 1,
	"ELITE": 1
}
