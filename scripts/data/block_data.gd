extends Resource
class_name BlockData

# 方块类别：掩体/炮塔/推进器/核心/特殊
enum BlockType { COVER, TURRET, THRUSTER, CORE, SPECIAL }

# 稀有度：核心通常可用 NONE 表示不参与稀有度掉落
enum Rarity { NONE, COMMON, RARE, EPIC, LEGENDARY }

# 唯一 ID（建议英文+下划线，方便做索引）
@export var id: String
# 显示名称（UI 用）
@export var display_name: String
# 方块类型
@export var block_type: BlockType
# 稀有度
@export var rarity: Rarity = Rarity.COMMON

# 占格尺寸，支持 1x1 / 2x2 / 3x3 ...
@export var size: Vector2i = Vector2i.ONE

# 最大生命值
@export var max_hp: int = 100

# 标签（用于合成/特殊条件判定）
@export var tags: Array[String] = []

# ===== 炮塔相关 =====
# 射界角度（360 为全向）
@export var turret_arc_deg: float = 360.0
# 是否无限弹药
@export var has_infinite_ammo: bool = true
# 有限弹药时最大值
@export var max_ammo: int = 0

# ===== 推进器相关 =====
# 正向推力系数（1.0 = 100%）
@export var thrust_forward: float = 1.0
# 反向推力系数（0.4 = 40%）
@export var thrust_backward: float = 0.4
# 推进器朝向（上下左右）
@export var thrust_direction: Vector2i = Vector2i.UP

# ===== 特殊方块相关 =====
# 冲突方块 ID 列表
@export var conflicts_with: Array[String] = []
# 邻近标签要求（key=tag, value=数量）
@export var required_tags_nearby: Dictionary = {}
