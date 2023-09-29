class_name HitBox
extends Area2D

var attack: int

func _init():
	collision_layer = 2
	collision_mask = 0

func disable():
	set_physics_process(false)

func enable():
	set_physics_process(true)
