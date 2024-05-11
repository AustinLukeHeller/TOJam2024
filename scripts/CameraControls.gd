extends Node3D

@export var startCamNode :Node3D
@export var tankCamNode : Node3D
@export var moveSpeed:=.2 as float
var targetNode:Node3D

func _ready():
	targetNode=startCamNode
	position=startCamNode.position
	
# Called when the node enters the scene tree for the first time.
func _switchTarget(newTarget:Node3D):
	targetNode=newTarget
	
func _followTargetAtSpeed(delta):	
	position=Vector3 (move_toward(position.x, targetNode.position.x,moveSpeed*delta),
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
