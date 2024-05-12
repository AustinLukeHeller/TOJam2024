extends Node3D

@export var mute := false
@export var tilt := false


func _input(_ev):
	if Input.is_action_just_released("Mute"):
		mute!=mute
		Score.add(100)
		print("new score:", Score.get_score())
