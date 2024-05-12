extends AnimatableBody3D

@export var sound: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var pop_player = $PopPlayer
@export var score = 5
signal test_complete


func _ready():
	pop_player.stream = sound


func test():
	if !Global.mute:
		pop_player.play()
	animation_player.play("hit")
	await animation_player.animation_finished
	emit_signal("test_complete")


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing():
		Score.add(score)
		if !Global.mute:
			pop_player.play()
		animation_player.play("hit")
