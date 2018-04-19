extends KinematicBody2D


const GRAVITY = 30
const ACCELERATION = 70
const MAX_SPEED = 400
const JUMP_HEIGHT = -700
const MAX_JUMP = 1	#Le nombre maximal de sauts possible
#const DASH = 5000

var motion = Vector2()
var jump_count = 0	#Pour faire des doubles saut

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION , MAX_SPEED) #Min renvoie l'argument le plus petit
#		if Input.is_action_just_pressed("dash"):
#			motion.x = DASH
#		$AnimatedSprite.flip_h = false
		$AnimationPlayer.play("Debut")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
#		if Input.is_action_just_pressed("dash"):
#			motion.x = -DASH
		$AnimationPlayer.play("Debut")
#		$AnimatedSprite.flip_h = true	#On inverse le sprite quand il va vers la gauche
	else:
		$AnimationPlayer.stop()
		friction = true
	
	#On incrémente jump_count pour empêcher le joueur de sauter à l'infini
	if jump_count < MAX_JUMP:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			jump_count += 1
	
	#Au sol on réinitialise jump_count pour pouvoir double saut à nouveau
	if is_on_floor():
		jump_count = 0
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, Vector2(0, -1))
	
#Quand on est touché, on affiche le HUD
func hit():
#	get_tree().paused = true
	$Camera2D/HUD.visible = true
	
	
	
	
	
	
