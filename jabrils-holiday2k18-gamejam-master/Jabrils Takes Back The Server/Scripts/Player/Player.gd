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
