extends CharacterBody3D

var Player: Node3D
@export var moveSpeed: float
@export var pointsOnKill: float
@export var explosion: Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	Player=get_node("../../../Tank")
	look_at(Player.position)
	pass # Replace with function body.

func _hit_player():
	print("hit player")
	Global.tilting()
	#spawn some particle effect maybe
	_spawn_explosion()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position-=transform.basis.z*moveSpeed*delta
	pass
	
func _spawn_explosion():
	
	var spawnPoint = get_parent()
	var newExplosion = load(explosion.resource_path).instantiate()
	spawnPoint.add_child(newExplosion)
	newExplosion.position = position
func _get_hit(body):
	body.queue_free()
	Score.add(pointsOnKill)
	_spawn_explosion()
	queue_free()
	

func _on_area_3d_body_entered(body):
	print(body.name)
	if(body.name=="Tank"):
		_hit_player()
	if(body.name.contains("outerball")):
		_get_hit(body)
	pass # Replace with function body.
