extends Node
class_name SynthesisSystem

# 配方表：key=recipe_id, value=RecipeData
var recipes: Dictionary = {}

# 批量设置配方
func set_recipes(recipe_list: Array[RecipeData]) -> void:
	recipes.clear()
	for recipe in recipe_list:
		recipes[recipe.recipe_id] = recipe

# 判断库存是否满足合成条件
func can_synthesize(recipe_id: String, inventory: Dictionary) -> bool:
	var recipe: RecipeData = recipes.get(recipe_id)
	if recipe == null:
		return false

	for block_id in recipe.inputs.keys():
		var need: int = int(recipe.inputs[block_id])
		var have: int = int(inventory.get(block_id, 0))
		if have < need:
			return false
	return true

# 执行合成：扣材料 + 加产物
func synthesize(recipe_id: String, inventory: Dictionary) -> bool:
	if not can_synthesize(recipe_id, inventory):
		return false

	var recipe: RecipeData = recipes[recipe_id]

	for block_id in recipe.inputs.keys():
		inventory[block_id] = int(inventory.get(block_id, 0)) - int(recipe.inputs[block_id])

	var output_id: String = recipe.output_block_id
	inventory[output_id] = int(inventory.get(output_id, 0)) + 1
	return true
