extends Resource
class_name FloorConfigData

# 第几层（建议从 1 开始）
@export var floor_index: int = 1

# 地图行列数
@export var rows: int = 12
@export var cols: int = 7

# 前 N 行禁止精英（降低开局难度）
@export var elite_forbidden_rows: int = 2

# 房间权重配置：key=房间名，value=权重
@export var room_weights: Dictionary = {
	"BATTLE": 4,
	"EVENT": 2,
	"SHOP": 1,
	"REPAIR": 1,
	"TREASURE": 1,
	"ELITE": 1
}
