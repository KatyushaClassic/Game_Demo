extends Node
class_name MapGenerator

# 房间类型枚举，UI 和逻辑都建议共用该定义
enum RoomType { BATTLE, ELITE, EVENT, SHOP, REPAIR, TREASURE, BOSS }

# 根据楼层配置资源生成地图
# 返回二维数组：grid[row][col] = RoomType
func generate_floor(config: FloorConfigData) -> Array:
	var rows := config.rows
	var cols := config.cols
	var grid: Array = []

	for r in range(rows):
		var row: Array = []
		for c in range(cols):
			row.append(_roll_room_type(config, r, rows))
		grid.append(row)

	# 最后一行全部改为 Boss 房，确保“每层终点Boss”
	for c in range(cols):
		grid[rows - 1][c] = RoomType.BOSS

	return grid

# 按配置中的权重随机一个房间类型
func _roll_room_type(config: FloorConfigData, row: int, rows: int) -> RoomType:
	if row == rows - 1:
		return RoomType.BOSS

	# 前几行禁精英，降低开局难度
	if row < config.elite_forbidden_rows:
		return [RoomType.BATTLE, RoomType.EVENT, RoomType.REPAIR].pick_random()

	# 把字典权重展开成随机池（新手容易理解，后续可优化性能）
	var pool: Array[RoomType] = []
	for key in config.room_weights.keys():
		var weight: int = max(int(config.room_weights[key]), 0)
		var room_type := _room_type_from_key(str(key))
		for _i in range(weight):
			pool.append(room_type)

	if pool.is_empty():
		# 兜底，避免配置错误导致崩溃
		return RoomType.BATTLE

	return pool.pick_random()

# 字符串 -> 房间枚举
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
