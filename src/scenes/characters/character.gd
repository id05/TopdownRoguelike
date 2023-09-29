extends CharacterBody2D
class_name Character
@export var max_health: int
var health: int

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
##intended speed of running animation, pexel per second
@export var animation_run_speed: int = 80
@export_category('kinematics')
@export var max_speed: float
@export var max_acc: float
##between 2 and 5
@export var friction: float = 3
@export var stop_speed: float = 1
##is current movement is been forced by something
#var forced_movement: bool

signal died(char: Character, from)
signal damage_taken(char: Character, from, damage: int)



func _ready():
	#sprite.play("run")
	health = max_health
	_on_animated_sprite_2d_animation_changed()
	sprite.animation_changed.connect(_on_animated_sprite_2d_animation_changed)

func damage(value: int, from):
	health -= value
	damage_taken.emit(value, from)
	if health <= 0:
		death(from)

func accelerate(wishdir: Vector2, acc: float, delta: float):
	var current_speed: float = velocity.dot(wishdir)
	var add_speed: float = max_speed - current_speed
	if add_speed <= 0:
		return
	velocity += wishdir * minf(acc * delta, add_speed)

func apply_firction(delta: float):
	var speed: float = velocity.length()
	if speed < stop_speed:
		velocity = Vector2.ZERO
		return
	else:
		var drop = speed * friction * delta
		velocity *= maxf(speed - drop, 0) / speed

func _process(delta: float):
	if velocity.length() > 0:
		var dir_factor = -sign(velocity.x) if sprite.flip_h else sign(velocity.x)
		sprite.speed_scale = dir_factor * velocity.length() / animation_run_speed
		sprite.play("run")
		move_and_slide()
	else:
		sprite.speed_scale = 1
		sprite.play("idle")

func death(from):
	died.emit(from)
	sprite.speed_scale = 1
	sprite.play("death")
	await sprite.animation_finished
	queue_free()


func _on_animated_sprite_2d_animation_changed():
	sprite.position.y = -sprite.sprite_frames.get_frame_texture(sprite.animation, 0).get_height() * 0.5 + 5
