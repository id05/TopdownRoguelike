extends Resource
class_name Item

enum RARITY {COMMON, UNUSUAL, RARE, LEGENDARY}

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var rarity: RARITY
