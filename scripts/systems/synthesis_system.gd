extends Node
class_name SynthesisSystem

# recipe_id -> {"inputs": {block_id: count}, "output": block_id}
var recipes: Dictionary = {}

func can_synthesize(recipe_id: String, inventory: Dictionary) -> bool:
	if not recipes.has(recipe_id):
		return false
	var recipe: Dictionary = recipes[recipe_id]
	var inputs: Dictionary = recipe["inputs"]
	for block_id in inputs.keys():
		if int(inventory.get(block_id, 0)) < int(inputs[block_id]):
			return false
	return true

func synthesize(recipe_id: String, inventory: Dictionary) -> bool:
	if not can_synthesize(recipe_id, inventory):
		return false
	var recipe: Dictionary = recipes[recipe_id]
	var inputs: Dictionary = recipe["inputs"]
	for block_id in inputs.keys():
		inventory[block_id] = int(inventory.get(block_id, 0)) - int(inputs[block_id])
	var output_id: String = recipe["output"]
	inventory[output_id] = int(inventory.get(output_id, 0)) + 1
	return true
