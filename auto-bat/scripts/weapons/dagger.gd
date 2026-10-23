extends weapon


func _on_timer_timeout() -> void:
	attack()
	var b = preload("res://scenes/weapons/effects/daggereffect.tscn").instantiate()
	get_parent().add_child(b)
	b.global_position = global_position
	
	$Timer.start(basecooldown * cooldownmult)
