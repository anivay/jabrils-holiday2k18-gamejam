extends Area2D

signal attack_finished

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 2


func _ready():
	set_physics_process(false)


func attack():
	_change_state(ATTACK)


func _change_state(new_state):
	current_state = new_state
	
	match current_state:
		IDLE: 
			set_physics_process(false)
		ATTACK:
			set_physics_process(true)
			# Play characters attack animation
			# Send signal that attack animation is done through the animation


func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if not body.id == "enemy":
			return
		body.take_damage(damage)
		
	set_physics_process(false)



func _on_AnimationPlayer_animation_finished(anim_name):
	if name == "attack":
		_change_state(IDLE)
		emit_signal("attack_finished")