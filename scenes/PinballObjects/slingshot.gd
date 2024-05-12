extends ScoreReliant

@export var fire: AudioStreamWAV
@export var force := 10.0
@export var score_event := "Rebound"
@onready var animation_player = $AnimationPlayer
@onready var fire_sound = $FireSound
@onready var shot_origin = $ShotOrigin
signal test_complete

@export var moveable:=false
@export var speed:=0
@export var horDelta:=0
@export var verDelta:=0

var startingPos;
var leftSide;
var rightSide;


func _ready():
	startingPos=position.x
	fire_sound.stream = fire
	
	rightSide = position.x+horDelta;
	leftSide = position.x-horDelta;
	


func test():
	hit()
	await animation_player.animation_finished
	emit_signal("test_complete")


func hit():
	if Global.mute:
		fire_sound.play()
	animation_player.play("hit")


func _on_area_3d_body_entered(body: RigidBody3D):
	if !animation_player.is_playing():
		hit()
		Score.event(score_event)
		var direction = (body.global_position - shot_origin.global_position)
		direction.y = 0
		direction = direction.normalized()
		body.apply_central_impulse(direction * force)
		
func _physics_process(delta):
	if Global.tilt ||!moveable||!passedScoreThreshold:
		return
	if Input.is_action_pressed("Left") && position.x>leftSide:
		position.x += -delta*speed
		
	if Input.is_action_pressed("Right")&& position.x<rightSide:
		position.x += delta*speed;
		
	
