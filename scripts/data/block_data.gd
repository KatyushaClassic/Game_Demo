extends Resource
class_name BlockData

# 方块大类
enum BlockType { COVER, TURRET, THRUSTER, CORE, SPECIAL }

# 稀有度：核心通常不使用稀有度，保留 NONE 作为兜底
enum Rarity { NONE, COMMON, RARE, EPIC, LEGENDARY }

# -------------------- 基础信息 --------------------
@export var id: String
@export var display_name: String
@export var block_type: BlockType
@export var rarity: Rarity = Rarity.COMMON

# 占格大小：支持 1x1、2x2、3x3...
@export var size: Vector2i = Vector2i.ONE

# 血量
@export var max_hp: int = 100

# 标签（用于联动/条件，如 "cannon"、"missile"）
@export var tags: Array[String] = []

# -------------------- 炮塔相关 --------------------
# 射界角度（360=全向）
@export var turret_arc_deg: float = 360.0

# 是否无限弹药
@export var has_infinite_ammo: bool = true

# 有限弹药时最大值
@export var max_ammo: int = 0

# -------------------- 推进器相关 --------------------
# 正向推力系数（你的设定是 100%）
@export var thrust_forward: float = 1.0

# 反向推力系数（你的设定是 40%）
@export var thrust_backward: float = 0.4

# 推进器朝向（上/下/左/右）
@export var thrust_direction: Vector2i = Vector2i.UP

# -------------------- 特殊方块相关 --------------------
# 冲突列表：若安装了这里的任意 id，则本方块不能装
@export var conflicts_with: Array[String] = []

# 安装条件：key=标签名，value=所需数量（邻近范围统计由外部逻辑负责）
@export var required_tags_nearby: Dictionary = {}
