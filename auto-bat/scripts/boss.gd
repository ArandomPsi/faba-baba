extends CharacterBody2D
@export var target : Node2D

var headrotationspeed : float = 0.05




func _process(delta: float) -> void:
	var v = (target.position-$body/head.global_position ).angle()
	$body/head.rotation = lerp_angle($body/head.rotation,v,headrotationspeed)
	
	if not $AnimationPlayer.is_playing():
		var anims : Array = $AnimationPlayer.get_animation_list() #maybe cache this
		$AnimationPlayer.play(anims.pick_random())
	

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
