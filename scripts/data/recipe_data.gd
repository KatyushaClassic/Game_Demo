extends Resource
class_name RecipeData

# 配方唯一 ID
@export var recipe_id: String
# 输入材料字典：key=方块ID，value=数量
@export var inputs: Dictionary = {}
# 输出方块 ID
@export var output_block_id: String
# 是否高级/传说配方（用于 UI 分类）
@export var is_advanced: bool = false
