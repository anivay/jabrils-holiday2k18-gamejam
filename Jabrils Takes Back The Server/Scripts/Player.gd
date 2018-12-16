extends KinematicBody2D

############################################
#                  STATS                   #
############################################

export var MULTI_JUMP = false
export var MAX_EXTRA_JUMPS = 1
var health = 100
var hunger = 50 # acts like MP

############################################
#                 MOVEMENT                 #
############################################
const UP = Vector2(0, -1)
const GRAVITY = 30
const ACCELERATION = 50
const MAX_SPEED = 250
const JUMP_HEIGHT = -600
const FRICTION_GROUND = 0.45
const FRICTION_AIR = 0.05

var motion = Vector2()

var remaining_jumps = MAX_EXTRA_JUMPS

func _physics_process(delta):
	var friction = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")		
	else:
		friction = true
		$Sprite.play("Idle")	
			
	# is_on_floor is pretty buggy if we want to prevent direction change while in air
	if is_on_floor():
		remaining_jumps = MAX_EXTRA_JUMPS
				
		if friction == true:
			motion.x = lerp(motion.x, 0, FRICTION_GROUND)	
			
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
			
		else:
			$Sprite.play("Fall")
			
		if friction == true:
			motion.x = lerp(motion.x, 0, FRICTION_AIR)
	
	# multi jumping 
	if Input.is_action_just_pressed("ui_up") and is_on_floor():	
		motion.y = JUMP_HEIGHT
		
	elif Input.is_action_just_pressed("ui_up") and MULTI_JUMP:
			if remaining_jumps > 0:
				motion.y = JUMP_HEIGHT
				remaining_jumps -= 1
			
	motion = move_and_slide(motion, UP)
	
	
############################################
#                 ATTACK                   #
############################################

func attack_physical():
	# $Sprite.play("Physical Attack")
	pass
	
func attack_ranged():
	# $Sprite.play("Ranged Attack")
	pass
	