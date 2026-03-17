extends Node
class_name MapGenerator

enum RoomType { BATTLE, ELITE, EVENT, SHOP, REPAIR, TREASURE, BOSS }

func generate_floor(floor_index: int, rows: int = 12, cols: int = 7) -> Array:
	var grid: Array = []
	for r in range(rows):
		var row: Array = []
		for c in range(cols):
			row.append(_roll_room_type(floor_index, r, rows))
		grid.append(row)

	# 最后一行设为 Boss 房
	for c in range(cols):
		grid[rows - 1][c] = RoomType.BOSS
	return grid

func _roll_room_type(floor_index: int, row: int, rows: int) -> RoomType:
	if row == rows - 1:
		return RoomType.BOSS
	if row < 2:
		return [RoomType.BATTLE, RoomType.EVENT, RoomType.REPAIR].pick_random()

	var weighted := [
		RoomType.BATTLE,
		RoomType.BATTLE,
		RoomType.EVENT,
		RoomType.SHOP,
		RoomType.REPAIR,
		RoomType.TREASURE,
		RoomType.ELITE
	]

	# 高层略微提高精英概率
	if floor_index >= 2:
		weighted.append(RoomType.ELITE)

	return weighted.pick_random()
