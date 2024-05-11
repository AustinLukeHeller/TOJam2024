extends Node

@export var score: float = 0.0
@export var scoreGoals:Array[float]
var currentGoal: int = 0
signal testSignal
# Called when the node enters the scene tree for the first time.
func _init():
	for i in range(0,scoreGoals.size()):
		add_user_signal("scoreEffect"+str(i),[])
	pass # Replace with function body.

func _gainPoints(points: float):
	score+=points
	#update ui
	_checkGoals()

func _checkGoals():
	if(score>=scoreGoals[currentGoal]):
		emit_signal("scoreEffect"+str(currentGoal))
		if(currentGoal<scoreGoals.size()-1):
			currentGoal+=1
		#else switch into infinite goals mode
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_6)):
		_gainPoints(600)
	pass
