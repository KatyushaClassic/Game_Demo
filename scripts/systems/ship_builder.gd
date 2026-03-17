extends Node
class_name ShipBuilder

# occupied: key=格子坐标(Vector2i), value=placed_blocks 下标
var occupied: Dictionary = {}

# placed_blocks 每项结构：{"block": BlockData, "origin": Vector2i}
var placed_blocks: Array[Dictionary] = []

# 判断某个方块是否可放置（不越界、不重叠）
func can_place_block(block: BlockData, origin: Vector2i, bounds: Rect2i) -> bool:
	for x in range(block.size.x):
		for y in range(block.size.y):
			var cell := origin + Vector2i(x, y)
			if not bounds.has_point(cell):
				return false
			if occupied.has(cell):
				return false
	return true

# 执行放置（调用前请先 can_place_block）
func place_block(block: BlockData, origin: Vector2i) -> void:
	var index := placed_blocks.size()
	placed_blocks.append({"block": block, "origin": origin})

	# 把该方块占据的所有格子登记到 occupied
	for x in range(block.size.x):
		for y in range(block.size.y):
			occupied[origin + Vector2i(x, y)] = index

# 移除一个已放置方块
func remove_block(index: int) -> void:
	if index < 0 or index >= placed_blocks.size():
		return

	var entry: Dictionary = placed_blocks[index]
	var block: BlockData = entry["block"]
	var origin: Vector2i = entry["origin"]

	# 先删 occupied 中旧记录
	for x in range(block.size.x):
		for y in range(block.size.y):
			occupied.erase(origin + Vector2i(x, y))

	# 再删列表并重建索引，避免下标错乱
	placed_blocks.remove_at(index)
	_rebuild_occupied()

# 连通性校验：从核心格子出发，是否可访问所有占据格子
# 用于保证船体不会出现“断开漂浮块”
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

# 4 邻接（上下左右）
func _neighbors4(cell: Vector2i) -> Array[Vector2i]:
	return [
		cell + Vector2i.UP,
		cell + Vector2i.DOWN,
		cell + Vector2i.LEFT,
		cell + Vector2i.RIGHT
	]

# 重新构建 occupied，确保 placed_blocks 下标变化后数据一致
func _rebuild_occupied() -> void:
	occupied.clear()
	for i in range(placed_blocks.size()):
		var entry: Dictionary = placed_blocks[i]
		var block: BlockData = entry["block"]
		var origin: Vector2i = entry["origin"]
		for x in range(block.size.x):
			for y in range(block.size.y):
				occupied[origin + Vector2i(x, y)] = i
