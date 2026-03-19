extends PanelContainer
class_name ExampleBlockCard

# 需要展示的示例方块 Resource
@export var block_data: BlockData

# 场景里用于显示标题的 Label 节点路径
@export var title_label_path: NodePath = NodePath("Margin/VBox/Title")
# 场景里用于显示详情的 RichTextLabel 节点路径
@export var body_label_path: NodePath = NodePath("Margin/VBox/Body")

# 进入场景时刷新 UI
func _ready() -> void:
	_refresh_ui()

# 把 BlockData 里的内容转换成更适合新手阅读的文本
func _refresh_ui() -> void:
	var title_label: Label = get_node_or_null(title_label_path)
	var body_label: RichTextLabel = get_node_or_null(body_label_path)
	if title_label == null or body_label == null:
		return
	if block_data == null:
		title_label.text = "未配置示例方块"
		body_label.text = "请在 Inspector 中给 ExampleBlockCard 指定一个 BlockData 资源。"
		return

	title_label.text = "示例方块：%s" % block_data.display_name
	body_label.text = "\n".join([
		"ID：%s" % block_data.id,
		"类型：%s" % _get_block_type_name(block_data.block_type),
		"稀有度：%s" % _get_rarity_name(block_data.rarity),
		"尺寸：%s x %s" % [block_data.size.x, block_data.size.y],
		"生命值：%s" % block_data.max_hp,
		"标签：%s" % ", ".join(block_data.tags),
		"补充说明：%s" % _build_extra_text(block_data)
	])

# 把方块类型枚举转成中文
func _get_block_type_name(value: int) -> String:
	match value:
		BlockData.BlockType.COVER:
			return "掩体"
		BlockData.BlockType.TURRET:
			return "炮塔"
		BlockData.BlockType.THRUSTER:
			return "推进器"
		BlockData.BlockType.CORE:
			return "核心"
		BlockData.BlockType.SPECIAL:
			return "特殊"
		_:
			return "未知"

# 把稀有度枚举转成中文
func _get_rarity_name(value: int) -> String:
	match value:
		BlockData.Rarity.NONE:
			return "无"
		BlockData.Rarity.COMMON:
			return "普通"
		BlockData.Rarity.RARE:
			return "稀有"
		BlockData.Rarity.EPIC:
			return "史诗"
		BlockData.Rarity.LEGENDARY:
			return "传说"
		_:
			return "未知"

# 根据方块类型补充不同说明
func _build_extra_text(data: BlockData) -> String:
	match data.block_type:
		BlockData.BlockType.TURRET:
			return "射界 %.0f°，%s" % [data.turret_arc_deg, "无限弹药" if data.has_infinite_ammo else "有限弹药"]
		BlockData.BlockType.THRUSTER:
			return "正推 %.0f%%，反推 %.0f%%" % [data.thrust_forward * 100.0, data.thrust_backward * 100.0]
		BlockData.BlockType.SPECIAL:
			return "冲突数 %s，条件数 %s" % [data.conflicts_with.size(), data.required_tags_nearby.size()]
		BlockData.BlockType.CORE:
			return "核心被摧毁则本局失败"
		_:
			return "用于演示当前场景中的方块配置方式"
