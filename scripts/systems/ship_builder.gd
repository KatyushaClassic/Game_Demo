extends Node
class_name ShipBuilder

# 占格索引：key=坐标，value=placed_blocks 下标
var occupied: Dictionary = {}

# 已放置方块列表：{"block": BlockData, "origin": Vector2i}
var placed_blocks: Array[Dictionary] = []

# 放置合法性：不能越界，不能重叠
func can_place_block(block: BlockData, origin: Vector2i, bounds: Rect2i) -> bool:
	for x in range(block.size.x):
		for y in range(block.size.y):
			var cell := origin + Vector2i(x, y)
			if not bounds.has_point(cell):
				return false
			if occupied.has(cell):
				return false
	return true

# 放置方块
func place_block(block: BlockData, origin: Vector2i) -> void:
	var index := placed_blocks.size()
	placed_blocks.append({"block": block, "origin": origin})

	for x in range(block.size.x):
		for y in range(block.size.y):
			occupied[origin + Vector2i(x, y)] = index

# 移除方块
func remove_block(index: int) -> void:
	if index < 0 or index >= placed_blocks.size():
		return

	var entry: Dictionary = placed_blocks[index]
	var block: BlockData = entry["block"]
	var origin: Vector2i = entry["origin"]

	for x in range(block.size.x):
		for y in range(block.size.y):
			occupied.erase(origin + Vector2i(x, y))

	placed_blocks.remove_at(index)
	_rebuild_occupied()

# 连通性校验：从核心出发是否能遍历所有占据格子
func validate_connectivity(core_cell: Vector2i) -> bool:
	if not occupied.has(core_cell):
		return false

	var visited: Dictionary = {}
	var queue: Array[Vector2i] = [core_cell]
	visited[core_cell] = true

	while not queue.is_empty():
		var current := queue.pop_front()
		for n in _neighbors4(current):
			if occupied.has(n) and not visited.has(n):
				visited[n] = true
				queue.append(n)

	return visited.size() == occupied.size()

# 四方向邻居
func _neighbors4(cell: Vector2i) -> Array[Vector2i]:
	return [
		cell + Vector2i.UP,
		cell + Vector2i.DOWN,
		cell + Vector2i.LEFT,
		cell + Vector2i.RIGHT
	]

# 重建占格字典（用于删除后修正索引）
func _rebuild_occupied() -> void:
	occupied.clear()
	for i in range(placed_blocks.size()):
		var entry: Dictionary = placed_blocks[i]
		var block: BlockData = entry["block"]
		var origin: Vector2i = entry["origin"]
		for x in range(block.size.x):
			for y in range(block.size.y):
				occupied[origin + Vector2i(x, y)] = i
