extends Node2D

@export var score: Node
@export var highscore: Node
@export var mission: Node
@export var lives: Node
@export var scoreManager: Node
@export var tallySpeed: float
var targetScore: float #for ticking up Score
var displayedScore: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	displayedScore=Score.get_score()
	Score.connect("high_score",_OnChangedHighScore)
	Score.connect("score_change",_OnGainedScore)
	_updateLabelWithFormatting(highscore,"HIGHSCORE: ",Score.get_high_score())
	_updateLabelWithFormatting(score,"SCORE: ",displayedScore)
	#_updateLabelWithFormatting(mission,"MISSION: ",scoreManager.getCurrentGoal())
	_OnLivesChanged(5)
	pass # Replace with function body.

func _updateLabelWithFormatting(label,text,number):
	label.text = text + "%06d" % [number]
	print("updated " + text + " to be " + str(number))
func _OnLivesChanged(newLives):
	lives.text = "BALLS: " + str(newLives)
func _OnGainedScore():
	targetScore=Score.get_score()
func _OnChangedHighScore():
	print("cmon now")
	_updateLabelWithFormatting(highscore,"HIGHSCORE: ",Score.get_high_score())
func _OnChangedGoal():
	_updateLabelWithFormatting(mission,"MISSION: ",scoreManager.getCurrentGoal())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(displayedScore!=targetScore):
		displayedScore = move_toward(displayedScore,targetScore,tallySpeed*delta)
		_updateLabelWithFormatting(score,"SCORE: ",displayedScore)
	
	pass
