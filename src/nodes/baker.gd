class_name Baker
extends Node

@export var enabled: bool = false
@export var directory: String = "res://src/scenes/"
@export var file_name: String = "baked_scene"


func _ready():
	if enabled:
		await owner.ready
		owner.baked = true
		enabled = false
		var scene: PackedScene = PackedScene.new()
		scene.pack(get_tree().current_scene)
		ResourceSaver.save(scene, directory + file_name + ".tscn")
