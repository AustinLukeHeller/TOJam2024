extends Node3D

@export var mute := false
@export var tilt := false
@export var tiltedLengthSeconds:= 2
@onready var timer := $Timer

#var tiltedTimer:= #T;
func _ready():
	timer.connect("timeout", timerFinished)

func _input(_ev):
	if Input.is_action_just_released("Mute"):
		mute!=mute
		Score.add(100)
		#tilting()
		
func tilting():
	tilt = true
	timer.start(tiltedLengthSeconds)
	print("started")
	
func timerFinished():
	tilt = false
	print("ended")
