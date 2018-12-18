extends KinematicBody2D
#extends 
############################################
#                  STATS                   #
############################################


var health = PlayerVARS.health
var hunger = PlayerVARS.hunger # acts like MP
var motion = PlayerVARS.motion




##### Process Movement #####
func _physics_process(delta):
	$Player_Movement.playerMovement()

	
############################################
#                 ATTACK                   #
############################################

func attack_physical():
	# $Sprite.play("Physical Attack")
	pass
	
func attack_ranged():
	# $Sprite.play("Ranged Attack")
	pass
	