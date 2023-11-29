extends KinematicBody2D

export(int) var speed = 80
export(int) var run_speed = 90
var animationPlayer = null
var animationTree = null
var animationState = null

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback") 
	animationTree.active = true

func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0


	velocity = velocity.normalized()

	if velocity == Vector2.ZERO:
		# Idle
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	else:
		# Walk
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Walk/blend_position", velocity)
		animationState.travel("Walk")

	if Input.is_action_pressed("ui_run"):
		move_and_slide(velocity * run_speed)
	
	move_and_slide(velocity * run_speed)
