extends Node
class_name MapGenerator

# 房间类型枚举
enum RoomType { BATTLE, ELITE, EVENT, SHOP, REPAIR, TREASURE, BOSS }

# 根据楼层配置生成二维地图
func generate_floor(config: FloorConfigData) -> Array:
	var rows := config.rows
	var cols := config.cols
	var grid: Array = []

	for r in range(rows):
		var row: Array = []
		for c in range(cols):
			row.append(_roll_room_type(config, r, rows))
		grid.append(row)

	# 最后一行固定 Boss
	for c in range(cols):
		grid[rows - 1][c] = RoomType.BOSS

	return grid

# 按权重随机房间
func _roll_room_type(config: FloorConfigData, row: int, rows: int) -> RoomType:
	if row == rows - 1:
		return RoomType.BOSS

	if row < config.elite_forbidden_rows:
		return [RoomType.BATTLE, RoomType.EVENT, RoomType.REPAIR].pick_random()

	var pool: Array[RoomType] = []
	for key in config.room_weights.keys():
		var weight: int = max(int(config.room_weights[key]), 0)
		var room_type := _room_type_from_key(str(key))
		for _i in range(weight):
			pool.append(room_type)

	if pool.is_empty():
		return RoomType.BATTLE

	return pool.pick_random()

# 字符串转枚举
func _room_type_from_key(key: String) -> RoomType:
	match key:
		"ELITE":
			return RoomType.ELITE
		"EVENT":
			return RoomType.EVENT
		"SHOP":
			return RoomType.SHOP
		"REPAIR":
			return RoomType.REPAIR
		"TREASURE":
			return RoomType.TREASURE
		"BOSS":
			return RoomType.BOSS
		_:
			return RoomType.BATTLE
