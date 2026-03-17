extends Node
class_name SynthesisSystem

var recipes: Dictionary = {}

func set_recipes(recipe_list: Array[RecipeData]) -> void:
	recipes.clear()
	for recipe in recipe_list:
		recipes[recipe.recipe_id] = recipe

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

func synthesize(recipe_id: String, inventory: Dictionary) -> bool:
	if not can_synthesize(recipe_id, inventory):
		return false

	var recipe: RecipeData = recipes[recipe_id]

	for block_id in recipe.inputs.keys():
		inventory[block_id] = int(inventory.get(block_id, 0)) - int(recipe.inputs[block_id])

	var output_id: String = recipe.output_block_id
	inventory[output_id] = int(inventory.get(output_id, 0)) + 1
	return true
