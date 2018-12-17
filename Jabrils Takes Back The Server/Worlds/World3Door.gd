extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for objDetected in bodies:
		print(objDetected.name)
		if objDetected.name == "Player":
			get_tree().change_scene("Worlds/World3.tscn")
		