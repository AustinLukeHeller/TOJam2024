extends CharacterBody3D

var Player: Node3D
@export var moveSpeed: float
# Called when the node enters the scene tree for the first time.
func _ready():
	Player=get_node("../../../Tank")
	look_at(Player.position)
	Player.connect("body_entered",_hit_player)
	pass # Replace with function body.

func _hit_player():
	print("hit player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position-=transform.basis.z*moveSpeed*delta
	pass
	

