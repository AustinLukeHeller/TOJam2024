extends StaticBody3D

@export var hit := false
@export var score:= 5

@onready var animation_player := $AnimationPlayer
@onready var hit_audio := $Hit
@onready var light := $Light

signal target_hit
signal test_complete


func on_hit():
		animation_player.play("hit")
		if !Global.mute:
			hit_audio.play()
		emit_signal("target_hit")
		hit = true
		light.activate()


func tick(tick_count: int):
	if tick_count % 2 == 0:
		light.activate()
	else:
		light.deactivate()


func test():
	animation_player.play("hit")
	hit = true
	light.activate()
	if !Global.mute:
		hit_audio.play()
	await animation_player.animation_finished
	emit_signal("test_complete")


func reset():
	if hit:
		animation_player.play("reset")
	hit = false
	light.deactivate()


func _on_area_3d_body_entered(_body):
	if !hit:
		Score.add(score)
		on_hit()
