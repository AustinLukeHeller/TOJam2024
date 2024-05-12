extends Node3D

@export var ballPrefab: Resource 	
@export var spawnLocation: Marker3D
@export var scoreManager: ScoreManager
@export var gameover: Resource
var lives: float


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

func spawnBall():
	print("spawning ball")
	var ball= load(ballPrefab.resource_path).instantiate()
	
	spawnLocation.add_child(ball)
	ball.global_position=spawnLocation.global_position
	print(spawnLocation.get_children())
	
func reset():
	for c in spawnLocation.get_children():
		c.queue_free()
	Score.reset()
	Global.tilt=false
	scoreManager.reset()
	lives =3
	spawnBall()

func _on_area_3d_body_entered(body):
	var found = false
	for c in spawnLocation.get_children():
		if(c.name==body.name):
			found = true
	if(found):
		body.queue_free()
		print("Destroying ball", spawnLocation.get_children().size())
		if(spawnLocation.get_children().size()<=1):
			looseLife()
		
func looseLife():
	lives-=1
	print("Lost Life, Count: ",lives)
	if(lives<=0):
		print("Game Over")
		Global.tilt=true#small hack to turn off stuff
		#spawnmenu
		var spawnPoint = get_tree().current_scene
		spawnPoint.add_child(load(gameover.resource_path).instantiate())
		get_node("Timer").start()
	else:
		spawnBall()
	


func _on_timer_timeout():
	reset()
	get_tree().reload_current_scene()
	pass # Replace with function body.
