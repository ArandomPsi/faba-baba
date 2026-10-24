extends CharacterBody2D

var shotcooldown : float = 0
var rocket_timer : float = 0.0

func _process(delta: float) -> void:
	var dir = Input.get_vector("left","right","up","down")
	velocity += dir * 5000 * delta
	velocity *= pow(0.9, delta * 60.0)
	$pivot.rotation_degrees = velocity.y * -0.05
	if dir == Vector2.ZERO:
		rocket_timer += delta
		$pivot/Sprite2D/GPUParticles2D.modulate.a = 1.0 - (rocket_timer/1.5)
	else:
		rocket_timer = 0.0
		$pivot/Sprite2D/GPUParticles2D.modulate.a += delta
	if Input.is_action_pressed("shoot") and shotcooldown < 0:
		shoot()
		shotcooldown = 0.15
	shotcooldown -= delta
	move_and_slide()

func shoot():
	var b = preload("res://scenes/babylittleblaster.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.position = position
	b.rotation = $pivot.rotation + PI

func fling(enemy_attack):
	if "velocity" in enemy_attack:
		velocity += enemy_attack.velocity * 5
	else:
		velocity += enemy_attack.transform.x * 2500

func _on_hurtbox_area_entered(area: Area2D) -> void:
	fling(area.get_parent())
	for i in range(3):
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property($pivot/Sprite2D, "self_modulate", Color.WHITE, 0.15)
		tween.tween_property($pivot/Sprite2D, "self_modulate", Color("#00d9ff"), 0.15)
		await tween.finished
