extends CharacterBody2D
@export var target : Node2D

var headrotationspeed : float = 0.05

var hp : int = 2000

func _ready() -> void:
	var ogy : float = position.y
	position.y += 1000
	var tween = create_tween()
	tween.tween_property(self,"position:y",ogy,1.2).set_trans(Tween.TRANS_CUBIC).set_delay(1)


func _process(delta: float) -> void:
	
	$hud/ProgressBar.value = hp
	
	#for collisions only
	velocity.x = 800
	
	#blah blah blah
	var v = (target.position-$body/head.global_position ).angle()
	$body/head.rotation = lerp_angle($body/head.rotation,v,headrotationspeed)
	
	if not $AnimationPlayer.is_playing():
		var anims : Array = $AnimationPlayer.get_animation_list() #maybe cache this
		anims.erase("obamahavedih") #placeholder anim
		$AnimationPlayer.play(anims.pick_random())
		#testing: $AnimationPlayer.play("attack2")
	

func attack1():
	for i in range(15):
		var b = preload("res://scenes/babal.tscn").instantiate()
		get_tree().current_scene.add_child(b)
		b.position = $body/head.global_position
		b.rotation_degrees = $body/head.rotation_degrees + randf_range(-20,20)
		$body/head.rotation_degrees += randf_range(-2,2)
		await get_tree().create_timer(0.1).timeout

func attack2():
	for i in range(8):
		var b = preload("res://scenes/dragonsballs.tscn").instantiate()
		get_tree().current_scene.add_child(b)
		b.position = position + Vector2(-30,300)


func changeheadrotaspeed(time:float = 0.8):
	headrotationspeed = 0.01
	await get_tree().create_timer(time).timeout
	headrotationspeed = 0.05

func hollowpurple():
	for i in range(10):
		var b = preload("res://scenes/hollowpurple.tscn").instantiate()
		get_parent().add_child(b)
		b.position = $body/head.global_position
		b.position.y += randf_range(-50,50)
		await get_tree().create_timer(0.3).timeout

func thefirstactuallynormalbullethellattack():
	for i in range(240):
		var b = preload("res://scenes/normiebullet.tscn").instantiate()
		get_tree().current_scene.add_child(b)
		b.position = $body/head/charge.global_position
		b.rotation = PI/6 * i + (PI * randf_range(0.5,0.05))
		await get_tree().create_timer(0.02).timeout

func bulletwave():
	for i in range(15):
		for e in range(20):
			var b = preload("res://scenes/normiebullet.tscn").instantiate()
			get_tree().current_scene.add_child(b)
			b.position = $body/head/charge.global_position
			b.look_at(target.position)
			b.rotation += 10 * PI/20 + (PI/20 * i * 10) + (PI * randf_range(-0.5,0.5))
		
		await get_tree().create_timer(0.2).timeout

func bulletvolley():
	print("yo")
	for i in range(5):
		for e in range(20):
			var b = preload("res://scenes/volley.tscn").instantiate()
			get_tree().current_scene.add_child(b)
			b.position = $body/head/charge.global_position
			b.look_at(target.position)
			
		
		await get_tree().create_timer(0.3).timeout
