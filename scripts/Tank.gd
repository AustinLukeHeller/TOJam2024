extends Node3D

@export var maxAngle: float
@export var turnAccel: float
@export var turnMaxSpeed: float

var velocity: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_2)):
		position+=Vector3.RIGHT*delta
	if(Input.is_action_pressed("Left")):
		velocity+=turnAccel*delta
	elif(Input.is_action_pressed("Right")):
		velocity-=turnAccel*delta
	else:
		velocity = move_toward(velocity,0,turnAccel)
	velocity = clamp(velocity,-turnMaxSpeed,turnMaxSpeed)
	
	rotation_degrees.y=clamp(rotation_degrees.y+velocity*delta,-maxAngle,maxAngle)
	if(abs(rotation_degrees.y)==maxAngle):
		velocity=0
	pass
