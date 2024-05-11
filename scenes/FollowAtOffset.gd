extends Node3D

class_name FollowAtOffset
@export var targetPos := "" # assign from editor
@onready var targetNode := get_node(targetPos) as Node3D
var offset: Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	offset=position-targetNode.position
	_followTargetInstant()
	pass # Replace with function body.

func _followTargetInstant():
	position=targetNode.position+offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_followTargetInstant()
	pass
