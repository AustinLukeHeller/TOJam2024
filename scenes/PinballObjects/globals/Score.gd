extends Node

@export var score_events := {
		"Points_Added" : 1000
	}

@export var _score := 0
@export var _high_score := 0
@export var _high_scores: Array = []
@export var cur_is_high_score := false

signal high_score
signal score_change
# Max number of high scores to store
const MAX_HIGH_SCORES := 10

# Path to save the high scores
const HIGH_SCORES_PATH := "user://high_scores.save"


func _ready():
	load_high_scores()


func event(e_name: String):
	assert(score_events.has(e_name))
	#Print.verbose( e_name + " %s points!" % score_events[e_name])
	add(score_events[e_name])


func add(val: int):
	_score += val
	emit_signal("score_change")
	print("new score:", Score.get_score())
	if _score > _high_score:
		_high_score = _score
		emit_signal("high_score")
		cur_is_high_score = true

func get_score():
	return _score


func get_high_score():
	return _high_score


func reset():
	if _score > _high_score:
		_high_score = _score
	update_high_scores()
	cur_is_high_score = false
	_score = 0
	save_high_scores()


func update_high_scores():
	_high_scores.append(_score)
	_high_scores.sort()
	_high_scores.reverse()
	while _high_scores.size() > MAX_HIGH_SCORES:
		_high_scores.pop_back()


func save_high_scores():
	var save_file = ConfigFile.new()
	save_file.set_value("score", "high_scores", _high_scores)
	save_file.save(HIGH_SCORES_PATH)


func load_high_scores():
	var save_file = ConfigFile.new()
	var error = save_file.load(HIGH_SCORES_PATH)
	if error == OK:
		_high_scores = save_file.get_value("score", "high_scores", [])
		_high_score = _high_scores[0]
