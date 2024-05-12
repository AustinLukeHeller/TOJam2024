extends ScoreReliant

@export var maxAngle: float
@export var turnAccel: float
@export var turnMaxSpeed: float
@export var progressionNode: Node
var activated: bool = false
var velocity2: float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_2)):
		position+=Vector3.RIGHT*delta
	if(passedScoreThreshold):
		if(Input.is_action_pressed("Left")):
			velocity2+=turnAccel*delta
		elif(Input.is_action_pressed("Right")):
			velocity2-=turnAccel*delta
		else:
			velocity2 = move_toward(velocity2,0,turnAccel)
		velocity2 = clamp(velocity2,-turnMaxSpeed,turnMaxSpeed)
		
		rotation_degrees.y=clamp(rotation_degrees.y+velocity2*delta,-maxAngle,maxAngle)
		if(abs(rotation_degrees.y)==maxAngle):
			velocity2=0
