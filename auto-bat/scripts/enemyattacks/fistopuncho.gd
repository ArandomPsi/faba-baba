extends weapon



func _on_timer_timeout() -> void:
	attack()
	$Timer.start(basecooldown * cooldownmult)
	var b = preload("res://scenes/enemyattacks/fistopunchoeffect.tscn").instantiate()
	get_parent().add_child(b)
	b.position.x -= 50
	
