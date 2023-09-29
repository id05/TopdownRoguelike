class_name MeleeWeapon
extends Node2D

@export var base_damage: int
var right: bool = true
@onready var hitbox: HitBox = $HitBox
@onready var player: AnimationPlayer = $AnimationPlayer
@onready var user: Character = owner.owner

func _ready():
	scale.x = 1 if right else -1
	hitbox.attack = base_damage
	hitbox.disable()

func use(target: Node2D = null):
	var target_direction: Vector2
	if target != null:
		target_direction = user.global_position.direction_to(target.global_position)
	else:
		target_direction = Vector2.UP.rotated(global_rotation)
	var attack_angle: = user.velocity.angle_to(target_direction)
	if (attack_angle < PI/4) && (attack_angle > -PI/4):
		#user approaches target
		thrust()
	elif (attack_angle < (PI * 3.0/4.0)) && (attack_angle > (-PI * 3.0/4.0)):
		#user moves perpendicularly
		cut()
	else:
		#user moves back from target
		parry()

func thrust():
	player.play("Sword/thrust")
	
func cut():
	player.play("Sword/cut")
	
func parry():
	pass
