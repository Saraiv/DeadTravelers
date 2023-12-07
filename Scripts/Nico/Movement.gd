extends KinematicBody2D

export(int) var speed = 80
export(int) var run_speed = 90
var animationPlayer = null
var animationTree = null
var animationState = null
var sprite = null
var scale_changed = false

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback") 
	sprite = $Sprite

func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity.x = 1.0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1.0

	if velocity == Vector2.ZERO:
		# Idle
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	else:
		# Walk
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Walking/blend_position", velocity)
		animationState.travel("Walking")

		if velocity.x > 0:
			get_node(".").scale.x = scale.y * 1
		elif velocity.x < 0:
			get_node(".").scale.x = scale.y * -1

	position += velocity * delta

	velocity = velocity.normalized()

	if Input.is_action_pressed("ui_run"):
		move_and_slide(velocity * run_speed)
	
	move_and_slide(velocity * speed)
