extends Node
class_name ShipBuilder

var occupied: Dictionary = {}

var placed_blocks: Array[Dictionary] = []

func can_place_block(block: BlockData, origin: Vector2i, bounds: Rect2i) -> bool:
	for x in range(block.size.x):
		for y in range(block.size.y):
			var cell := origin + Vector2i(x, y)
			if not bounds.has_point(cell):
				return false
			if occupied.has(cell):
				return false
	return true

func place_block(block: BlockData, origin: Vector2i) -> void:
	var index := placed_blocks.size()
	placed_blocks.append({"block": block, "origin": origin})

	for x in range(block.size.x):
		for y in range(block.size.y):
			occupied[origin + Vector2i(x, y)] = index

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

func _neighbors4(cell: Vector2i) -> Array[Vector2i]:
	return [
		cell + Vector2i.UP,
		cell + Vector2i.DOWN,
		cell + Vector2i.LEFT,
		cell + Vector2i.RIGHT
	]

func _rebuild_occupied() -> void:
	occupied.clear()
	for i in range(placed_blocks.size()):
		var entry: Dictionary = placed_blocks[i]
		var block: BlockData = entry["block"]
		var origin: Vector2i = entry["origin"]
		for x in range(block.size.x):
			for y in range(block.size.y):
				occupied[origin + Vector2i(x, y)] = i
