extends KinematicBody2D

const GRAVITY = 20
const UP = Vector2(0,-1)
const SPEED = 200

var motion = Vector2()

var jumpCount = 5
var randDir = randi()%11+1

func _ready():
	pass

func _physics_process(delta):
	motion.y +=GRAVITY
		##### JUMPING LOGIC #####
	if is_on_floor() and jumpCount > 0 and $Timer.time_left == 0:
		randDir = randi()%11+1
		if randDir >= 5:
			$Sprite.flip_h = true
			$Sprite.play("Jump")
			motion.x = SPEED
			motion.y = -SPEED
		else:
			$Sprite.flip_h = false
			$Sprite.play("Jump")
			motion.x = -SPEED
			motion.y = -SPEED
		
		jumpCount = jumpCount-1
	elif is_on_floor():
		$Sprite.play("Idle")
		motion.x = 0
		jumpCount = 1
		motion.x = lerp(motion.x,0,0.2)

	motion = move_and_slide(motion, UP)
	
	#print("timer: ",$Timer.time_left)
	#print(randDir)
	pass
	