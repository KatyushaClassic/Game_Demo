extends Resource
class_name BlockData

enum BlockType { COVER, TURRET, THRUSTER, CORE, SPECIAL }

enum Rarity { NONE, COMMON, RARE, EPIC, LEGENDARY }

@export var id: String
@export var display_name: String
@export var block_type: BlockType
@export var rarity: Rarity = Rarity.COMMON

@export var size: Vector2i = Vector2i.ONE

@export var max_hp: int = 100

@export var tags: Array[String] = []

@export var turret_arc_deg: float = 360.0

@export var has_infinite_ammo: bool = true

@export var max_ammo: int = 0

@export var thrust_forward: float = 1.0

@export var thrust_backward: float = 0.4

@export var thrust_direction: Vector2i = Vector2i.UP

@export var conflicts_with: Array[String] = []

@export var required_tags_nearby: Dictionary = {}
