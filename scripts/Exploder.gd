extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _explode():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("scalin")
	scale+=Vector3.ONE*.2 *delta
	rotate_z(delta*1.2)
	pass
