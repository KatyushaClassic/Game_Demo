extends Node
class_name SpecialModuleManager

var installed_special_ids: Array[String] = []

func can_install(candidate: BlockData, nearby_tag_counter: Dictionary, installed_blocks: Dictionary) -> bool:
	if candidate.block_type != BlockData.BlockType.SPECIAL:
		return false

	for existing_id in installed_special_ids:
		var existing: BlockData = installed_blocks.get(existing_id)
		if existing == null:
			continue
		if candidate.id in existing.conflicts_with:
			return false
		if existing.id in candidate.conflicts_with:
			return false

	for tag_name in candidate.required_tags_nearby.keys():
		var need := int(candidate.required_tags_nearby[tag_name])
		var have := int(nearby_tag_counter.get(tag_name, 0))
		if have < need:
			return false

	return true

func install_special(special_id: String) -> void:
	if special_id not in installed_special_ids:
		installed_special_ids.append(special_id)
