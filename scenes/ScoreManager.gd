extends Node3D
class_name ScoreManager

@export var triggers: Array[ScoreReliant] = []
@export var scoreThresholds: Array[float] = []
var currentThreshold = -1;
signal goal_changed
func _ready():
	reset()

func reset():
	for i in triggers.size():
		triggers[i].passedScoreThreshold = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currentScore = Score.get_score();
	if(scoreThresholds.size()>currentThreshold+1):
		if(currentScore>=scoreThresholds[currentThreshold+1]):
			passedThreshold()
			
func passedThreshold():
	currentThreshold+=1
	emit_signal("goal_changed")
	if(triggers.size()>currentThreshold):
		triggers[currentThreshold].passedScoreThreshold=true
func getCurrentGoal() ->float:
	return scoreThresholds[currentThreshold]

