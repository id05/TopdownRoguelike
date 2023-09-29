class_name Mob
extends Character

@export var circle_radius: int
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
#@export var ai: 

func _ready():
	super._ready()
	nav_agent.velocity_computed.connect(move)

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	nav_agent.velocity = (nav_agent.get_next_path_position() - position).normalized() * max_speed
	
	
#func _process(delta):
	#super._process(delta)

func move(_velocity: Vector2):
	velocity = _velocity

