extends Resource
class_name RecipeData

# 合成配方唯一 ID
@export var recipe_id: String

# 输入材料：key=方块ID，value=数量
@export var inputs: Dictionary = {}

# 输出方块 ID
@export var output_block_id: String

# 是否为传说/高级配方（用于 UI 分类）
@export var is_advanced: bool = false
