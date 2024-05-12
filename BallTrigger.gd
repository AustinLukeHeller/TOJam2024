extends Node3D

@export var ballHolder: Marker3D

signal ballEntered(body)

func _on_area_3d_body_entered(body):
	var found = false
	for c in ballHolder.get_children():
		if(c.name==body.name):
			found = true
	if(found):
		print("emittings")
		emit_signal("ballEntered",body)
