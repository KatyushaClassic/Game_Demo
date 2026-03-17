extends Node
class_name SpecialModuleManager

# 当前已装配的特殊方块 ID 列表
var installed_special_ids: Array[String] = []

# 判断候选特殊方块是否可安装
# nearby_tag_counter: 邻近标签统计（例如 {"cannon": 2}）
# installed_blocks: 已安装方块字典（key=id, value=BlockData）
func can_install(candidate: BlockData, nearby_tag_counter: Dictionary, installed_blocks: Dictionary) -> bool:
	# 只有 SPECIAL 类型才由此系统处理
	if candidate.block_type != BlockData.BlockType.SPECIAL:
		return false

	# 逐个检查冲突关系（双向检查更安全）
	for existing_id in installed_special_ids:
		var existing: BlockData = installed_blocks.get(existing_id)
		if existing == null:
			continue

		if candidate.id in existing.conflicts_with:
			return false
		if existing.id in candidate.conflicts_with:
			return false

	# 检查安装条件（周边标签数量是否满足）
	for tag_name in candidate.required_tags_nearby.keys():
		var need := int(candidate.required_tags_nearby[tag_name])
		var have := int(nearby_tag_counter.get(tag_name, 0))
		if have < need:
			return false

	return true

# 真正安装（调用前建议先 can_install）
func install_special(special_id: String) -> void:
	if special_id not in installed_special_ids:
		installed_special_ids.append(special_id)
