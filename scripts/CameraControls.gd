extends FollowAtOffset

#camera follows at its current offset the tank. offset can be changed from one node to another


@export var startCamPos := "" # assign from editor
@export var tankCamPos := "" # assign from editor
@onready var startCamNode := get_node(startCamPos) as Node3D
@onready var tankCamNode := get_node(tankCamPos) as Node3D
@export var moveSpeed: float
var moving: bool =false
# Called when the node enters the scene tree for the first time.
func _switchTarget(newTarget:Node3D):
	if(!moving):
		print("yart")
		targetNode=newTarget
	pass
func _followTargetAtSpeed(delta):
	position=Vector3 (move_toward(position.x,targetNode.position.x,moveSpeed*delta),
	move_toward(position.y,targetNode.position.y,moveSpeed*delta),
	move_toward(position.z,targetNode.position.z,moveSpeed*delta))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_0)):
		_switchTarget(tankCamNode)
	elif(Input.is_key_pressed(KEY_1)):
		_switchTarget((startCamNode))
	_followTargetAtSpeed(delta)
	pass
