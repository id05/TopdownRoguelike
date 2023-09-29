class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	
func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("hit"):
		owner.hit(hitbox.attack)
