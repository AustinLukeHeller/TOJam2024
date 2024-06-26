extends Node3D

@export var wait_time := 2.5
@export var force := 10
@export var enter_sound : AudioStreamWAV
@export var exit_sound : AudioStreamWAV
@export var janky_bugfix: bool = true
@export var score:= 100
@onready var enter_audio := $Enter_Audio
@onready var exit_audio := $Exit_Audio
@onready var throw := $Throw
var active := false


func _ready():
	enter_audio.stream = enter_sound
	exit_audio.stream = exit_sound


func _on_area_3d_body_entered(body: RigidBody3D):
	if !active:
		active = true
		Score.add(score)
		if !Global.mute and enter_audio.stream != null:
			enter_audio.play()
		if janky_bugfix:
			body.move(Vector3.DOWN * 10000)
		
		await get_tree().create_timer(wait_time).timeout
		if !Global.mute and exit_audio.stream != null:
			exit_audio.play()
#		Print.verbose( "%s Scoop activated. Throwing from %s with force %s" % [name, throw.global_position, -throw.basis.y * force])
		body.throw(throw.global_position, -throw.global_transform.basis.y * force)
		active = false
