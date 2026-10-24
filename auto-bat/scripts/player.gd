extends CharacterBody2D

var shotcooldown : float = 0

func _process(delta: float) -> void:
	velocity += Input.get_vector("left","right","up","down") * 5000 * delta
	velocity *= pow(0.9, delta * 60.0)
	$pivot.rotation_degrees = velocity.y * -0.05
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
	print("yo")
