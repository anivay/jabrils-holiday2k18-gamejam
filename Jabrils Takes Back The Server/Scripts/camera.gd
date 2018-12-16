extends Camera2D

func _process(delta):
	var pos = get_node("../Player").global_position - Vector2(0,16)
	var x floor(pos.x / 160) * 160
	