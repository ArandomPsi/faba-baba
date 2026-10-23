extends weapon


func _on_timer_timeout() -> void:
	var s = preload("res://scenes/weapons/effects/ninjastar.tscn").instantiate()
	get_parent().add_child(s)
	s.global_position = global_position
	await s.hitbox.area_entered
	attack()
	var b = preload("res://scenes/weapons/effects/daggereffect.tscn").instantiate()
	get_parent().add_child(b)
	b.global_position = s.global_position
	await get_tree().create_timer(0.25).timeout
	s.speed = 0.0
	await get_tree().create_timer(0.1).timeout
	s.speed = -1500.0
	await s.hitbox.area_entered
	attack()
	var c = preload("res://scenes/weapons/effects/daggereffect.tscn").instantiate()
	get_parent().add_child(c)
	c.global_position = s.global_position
	await get_tree().create_timer(2.0).timeout
	s.queue_free()
	
	$Timer.start(basecooldown * cooldownmult)
