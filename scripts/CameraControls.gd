extends Camera3D

#camera follows at its current offset the tank. offset can be changed from one node to another


@export var startCamPos := "" # assign from editor
@export var tankCamPos := "" # assign from editor
@export var targetPos := "" # assign from editor
@onready var startCamNode := get_node(startCamPos) as Node3D
@onready var tankCamNode := get_node(tankCamPos) as Node3D
@onready var targetNode := get_node(targetPos) as Node3D
@export var moveSpeed: float
var currentOffsetNode: Node3D
var currentCameraPosition: Vector3
var currentOffset: Vector3
var moving: bool =false
# Called when the node enters the scene tree for the first time.
func _ready():
	currentOffsetNode=startCamNode
	position=currentOffsetNode.position
	rotation = currentOffsetNode.rotation
	currentCameraPosition = currentOffsetNode.position
	currentOffset=currentCameraPosition - targetNode.position
	pass # Replace with function body.

func _switchOffsetNode(offsetNode: Node3D):
	if(!moving):
		print("yart")
		currentOffsetNode=offsetNode
		moving=true
	pass
func _followTarget():
	position=targetNode.position+ currentOffset
func _lerpToNewCamPos(delta):
	position=Vector3(move_toward(position.x,currentOffsetNode.position.x,moveSpeed*delta),
	move_toward(position.y,currentOffsetNode.position.y,moveSpeed*delta),
	move_toward(position.z,currentOffsetNode.position.z,moveSpeed*delta))
	currentCameraPosition = position
	currentOffset=currentCameraPosition - targetNode.position
	
	if(position==currentOffsetNode.position):
		moving=false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_0)):
		_switchOffsetNode(tankCamNode)
	elif(Input.is_key_pressed(KEY_1)):
		_switchOffsetNode((startCamNode))
	_followTarget()
	if(moving):
		_lerpToNewCamPos(delta)
	pass
