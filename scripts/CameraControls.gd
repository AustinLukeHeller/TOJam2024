extends Node3D

@export var startCamNode :Node3D
@export var tankCamNode : Node3D
@export var moveSpeed:=.2 as float
@export var rotSpeed:=.2 as float
var targetNode:Node3D

func _ready():
	targetNode=startCamNode
	position=startCamNode.position
	rotation_degrees=startCamNode.rotation_degrees
# Called when the node enters the scene tree for the first time.
func _switchTarget(newTarget:Node3D):
	targetNode=newTarget
	
func _followTargetAtSpeed(delta):	
	position=Vector3 (move_toward(position.x, targetNode.position.x,moveSpeed*delta),
	move_toward(position.y,targetNode.position.y,moveSpeed*delta),
	move_toward(position.z,targetNode.position.z,moveSpeed*delta))
	rotation_degrees = Vector3 (move_toward(rotation_degrees.x, targetNode.rotation_degrees.x,rotSpeed*delta),
	move_toward(rotation_degrees.y,targetNode.rotation_degrees.y,rotSpeed*delta),
	move_toward(rotation_degrees.z,targetNode.rotation_degrees.z,rotSpeed*delta))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_0)):
		_switchTarget(tankCamNode)
	elif(Input.is_key_pressed(KEY_1)):
		_switchTarget((startCamNode))
	_followTargetAtSpeed(delta)
	pass
