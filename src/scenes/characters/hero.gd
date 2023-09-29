extends Character

@onready var hands: = $Hands
@onready var label: Label = $Label
func get_controls_movement_vec() -> Vector2:
	var vec = Vector2.ZERO
	if Input.is_action_pressed("Down"):
		vec.y += 1
	if Input.is_action_pressed("Up"):
		vec.y -= 1
	if Input.is_action_pressed("Left"):
		vec.x -= 1
	if Input.is_action_pressed("Right"):
		vec.x += 1
	vec = vec.normalized()
	return vec



func get_aim() -> Vector2:
	return get_local_mouse_position()
	
	
func _physics_process(delta):
	apply_firction(delta)
	accelerate(get_controls_movement_vec(), max_acc, delta)

func _process(delta):
	super._process(delta)
	label.text = "Speed: %s pixels" % floorf(velocity.length())
	if  not hands.animating:
		var aim_point: = get_aim()
		hands.direction = aim_point
		sprite.flip_h = aim_point.x < 0
		if Input.is_action_just_pressed("left-click"):
			hands.use_right()
