class_name Hands
extends Node2D

@onready var left: Node2D = $Left
@onready var right: Node2D = $Right
@onready var base_left_position: = left.position
@onready var base_right_position: = right.position
var hand_length: int = 3

var weapon_right: Weapon
var weapon_left: Weapon

var animating: bool = false

var direction: Vector2:
	get:
		return direction
	set(value):
		direction = value.normalized()
		var global = to_global(value)
		left.look_at(global)
		left.rotate(PI/2)
		right.look_at(global)
		right.rotate(PI/2)
		left.position = base_left_position + direction * hand_length
		right.position = base_right_position + direction * hand_length
		left.z_index = sign(-direction.x + direction.y)
		right.z_index = sign(direction.x + direction.y)

func use_left():
	pass

func use_right(target = null):
	right.get_child(0).use(target)

