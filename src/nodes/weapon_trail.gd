class_name WeaponTrail
extends Line2D


var begin_pos: Vector2
@export var middle_marker: Node2D
@export var weapon_marker: Node2D



func bezier_quad(p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var q0 = lerp(p1, p2, t)
	var q1 = lerp(p2, p3, t)
	return lerp(q0, q1, t)


func setup():
	begin_pos = to_local(weapon_marker.global_position)

func draw_bezier(seg_number: int):
	var middle_marker_pos = to_local(middle_marker.global_position)
	var weapon_marker_pos = to_local(weapon_marker.global_position)
	var step: float = 1.0/seg_number
	for i in range(seg_number):
		var point = bezier_quad(begin_pos, middle_marker_pos, weapon_marker_pos, step * i)
		add_point(point)
		print(point)

