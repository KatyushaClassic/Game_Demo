extends Node
class_name SpecialModuleManager

# 已安装特殊方块 ID 列表
var installed_special_ids: Array[String] = []

# 检查是否可安装候选特殊方块
func can_install(candidate: BlockData, nearby_tag_counter: Dictionary, installed_blocks: Dictionary) -> bool:
	if candidate.block_type != BlockData.BlockType.SPECIAL:
		return false

	# 冲突检查：双向判断
	for existing_id in installed_special_ids:
		var existing: BlockData = installed_blocks.get(existing_id)
		if existing == null:
			continue

		if candidate.id in existing.conflicts_with:
			return false
		if existing.id in candidate.conflicts_with:
			return false

	# 邻近条件检查
	for tag_name in candidate.required_tags_nearby.keys():
		var need := int(candidate.required_tags_nearby[tag_name])
		var have := int(nearby_tag_counter.get(tag_name, 0))
		if have < need:
			return false

	return true

# 安装特殊方块
func install_special(special_id: String) -> void:
	if special_id not in installed_special_ids:
		installed_special_ids.append(special_id)
