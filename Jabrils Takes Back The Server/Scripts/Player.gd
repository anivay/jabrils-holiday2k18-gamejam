extends KinematicBody2D

const UP = Vector2(0, -1)
const MAX_JUMPS = 1
const GRAVITY = 30
const ACCELERATION = 50
const MAX_SPEED = 250
const JUMP_HEIGHT = -600
const FRICTION_GROUND = 0.45
const FRICTION_AIR = 0.05

var motion = Vector2()

var remaining_jumps = MAX_JUMPS

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
		remaining_jumps = MAX_JUMPS
				
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
	if Input.is_action_just_pressed("ui_up"):	
		if remaining_jumps > 0:
			remaining_jumps -= 1
			motion.y = JUMP_HEIGHT
	
			
	motion = move_and_slide(motion, UP)
	