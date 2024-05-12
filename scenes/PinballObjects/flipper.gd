extends ScoreReliant

@export var rotation_direction := 1.0  # Use 1.0 for clockwise and -1.0 for counter-clockwise
@export var flipper_rotation_speed := 2.5
@export var flipper_max_rotation := 45.0  # Set max rotation always positive
@export var flipper_min_rotation := 0.0  # Min rotation should always be less than max rotation
@onready var flip_sound = $Flip_Sound
@onready var return_sound = $Return_Sound



func _physics_process(delta):	
	if Global.tilt || !passedScoreThreshold:
		return
	if (rotation_direction < 0 and Input.is_action_pressed("Right")) or (rotation_direction > 0 and Input.is_action_pressed("Left")):
		rotation_degrees.y = lerp(rotation_degrees.y, flipper_max_rotation * rotation_direction, flipper_rotation_speed * delta)
	else:
		rotation_degrees.y = lerp(rotation_degrees.y, flipper_min_rotation * rotation_direction, flipper_rotation_speed * delta)
	if !Global.mute and (Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right")):
		flip_sound.play()
	if !Global.mute and (Input.is_action_just_released("Left") or Input.is_action_just_released("Right")):
		return_sound.play()
