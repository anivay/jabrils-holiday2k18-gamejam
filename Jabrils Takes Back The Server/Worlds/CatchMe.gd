extends Area2D
var array  = ['Player', 'Frog'] # use an array whitelist to avoid unexpected teleports
var targetPos = Vector2(100, 0) # In the future we could refer targetPos to a Scene object, and place that at the target coords


	##### Teleport any entities to targetPos #####
func _on_CatchMe_body_exited(body):
	if body.name in array: 
		body.motion.x = 0
		body.position = targetPos
		print(body.name,": has been teleported ")
	else:
		print(body.name,"Is out of GameArea - it will not be teleported")
