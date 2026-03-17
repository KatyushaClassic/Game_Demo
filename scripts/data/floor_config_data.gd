extends Resource
class_name FloorConfigData

@export var floor_index: int = 1

@export var rows: int = 12
@export var cols: int = 7

@export var elite_forbidden_rows: int = 2

@export var room_weights: Dictionary = {
	"BATTLE": 4,
	"EVENT": 2,
	"SHOP": 1,
	"REPAIR": 1,
	"TREASURE": 1,
	"ELITE": 1
}
