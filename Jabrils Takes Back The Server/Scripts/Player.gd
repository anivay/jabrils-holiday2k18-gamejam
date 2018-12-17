extends KinematicBody2D

############################################
#                  STATS                   #
############################################

export var MAX_EXTRA_JUMPS = 1 ### Editing through the editor does NOT work | unknown why
var remaining_jumps = 0
var health = PlayerVARS.health
var hunger = PlayerVARS.hunger # acts like MP

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

const camera_Smoothing_NORMAL = 4 ### Anything below 5 and we get a neat sway like effect
const camera_Smoothing_FAST = 20 ### The fastest the camera can adjust to player speed - if low, the play will be out of frame
var motion = Vector2()


func _physics_process(delta):
	var friction = false
	#	GRAVITY		#
	motion.y += GRAVITY

#####################################################
#		INPUT, MOVEMENT & ANIMATION HANDLING#		#
#####################################################
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
			
	
			##### FRICTION | FALLING / JUMPING ANIMATIONS #####
	if is_on_floor(): # is_on_floor is pretty buggy if we want to prevent direction change while in air
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
	
			##### REGULAR JUMPING #####
	if Input.is_action_just_pressed("ui_up") and is_on_floor():	
		#print("JUMP PRESSED ",PlayerVARS.MULTI_JUMP)
		motion.y = JUMP_HEIGHT
			###### MULTI-JUMPING #####
	elif Input.is_action_just_pressed("ui_up") and PlayerVARS.MULTI_JUMP:
			if remaining_jumps > 0:
				motion.y = JUMP_HEIGHT
				remaining_jumps -= 1

			##### TOGGLE MULTI-JUMP #####
	if Input.is_action_just_pressed("toggle_multi_jump"):
		if PlayerVARS.MULTI_JUMP:
			PlayerVARS.MULTI_JUMP = false
		else:
			PlayerVARS.MULTI_JUMP = true


		##### IF PLAYER MOVING QUICKY ADJUST CAMERA SPEED TO KEEP UP #####
	if motion.y >= 1000:
		if $Camera2D.smoothing_speed < camera_Smoothing_FAST:
			$Camera2D.smoothing_speed = $Camera2D.smoothing_speed+1
	else:
		$Camera2D.smoothing_speed = camera_Smoothing_NORMAL
	#print($Camera2D.smoothing_speed, "PLAYER MOTION: ", motion.x," ", motion.y)
	
	
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
	