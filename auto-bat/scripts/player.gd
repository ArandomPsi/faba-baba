extends CharacterBody2D

var shotcooldown : float = 0
var rocket_timer : float = 0.0

var stage : int = 0

var hp : int = 5

@export var enemy : Node2D
@export var attemptthingy : Label

@onready var simpleboards = $SimpleBoardsApi

var highscore : float = 0

var alreadydead : bool = false

var attempts : int = 0


func _ready() -> void:
	restart()
	
	# Set the API key (from your SimpleBoards dashboard)
	simpleboards.set_api_key("7499c2ec-05a7-4f87-8cc0-e90f6cc0baae")

	
	
	

func restart():
	
	highscore = clampi(roundi((1.0 - enemy.hp / 2000.0) * 100.0), 0, 100)
	
	
	enemy.hp = 2000
	position = Vector2(851.0,344)
	stage = 1
	hp = 10 + (2 * (stage-1)) #two more hp every stage
	attempts += 1
	attemptthingy.text = "attempts - " + str(attempts)
	attemptthingy.newattempt()
	$hp.max_value = hp
	
	
	if highscore > global.transferscore:
		global.transferscore = highscore
		await simpleboards.send_score_without_id("533cfd29-3759-446d-24b1-08df32091af1",global.playername,str(global.transferscore),"{}")
	

func _process(delta: float) -> void:
	if hp > 0:
		var dir = Input.get_vector("left","right","up","down")
		velocity += dir * 5000 * delta
		velocity *= pow(0.9, delta * 60.0)
		$pivot.rotation_degrees = velocity.y * -0.05
		#if dir == Vector2.ZERO:
			#rocket_timer += delta
			#$pivot/Sprite2D/GPUParticles2D.modulate.a = 1.0 - (rocket_timer/1.5)
		#else:
			#rocket_timer = 0.0
			#$pivot/Sprite2D/GPUParticles2D.modulate.a += delta
	
	$hp.self_modulate.a = lerpf($hp.self_modulate.a,0.0,0.05)
	$hp.value = hp
	
	
	if Input.is_action_pressed("shoot") and shotcooldown < 0:
		shoot()
		shotcooldown = 0.15
	shotcooldown -= delta
	move_and_slide()

func shoot():
	if stage == 1:
		var b = preload("res://scenes/babylittleblaster.tscn").instantiate()
		get_tree().current_scene.add_child(b)
		b.position = position
		b.rotation = $pivot.rotation + PI
	else:
		for i in range(stage):
			var b = preload("res://scenes/babylittleblaster.tscn").instantiate()
			get_tree().current_scene.add_child(b)
			b.position = position
			b.rotation = $pivot.rotation + PI
			b.rotation_degrees += 3 * (stage - i) - (3* stage/2)

func fling(enemy_attack):
	var b = preload("res://scenes/hiteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.position = position
	b.modulate = Color("70d4ff")
	
	hp -= 1
	$hp.self_modulate.a = 15
	if hp < 1 and not alreadydead:
		alreadydead
		deadcutscene()
	
	if "velocity" in enemy_attack:
		velocity = enemy_attack.velocity * 2
	else:
		velocity = enemy_attack.transform.x * 500
	
	$Camera2D.camerashake = 5

func deadcutscene():
	Engine.time_scale = 0.1
	$hud/Label.visible = true
	$hud/Label.modulate.a = 0
	var tween = create_tween()
	$Camera2D.reset_smoothing()
	tween.set_speed_scale(10)
	tween.tween_property($Camera2D,"zoom",Vector2(2,2),0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(1)
	tween.tween_property($hud/Label,"modulate:a",1.0,0.8)
	tween.tween_method(labelshine,0.0,1.0,0.05)
	tween.tween_property($hud/Label,"modulate:a",0.0,0.8)
	await tween.finished
	alreadydead = false
	Engine.time_scale = 1.0
	restart()

func labelshine(va):
	$Camera2D.camerashake = 10
	$hud/Label/quickshine.emitting = true
	$hud/Label.text = str(attempts + 1)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if hp > 0:
		fling(area.get_parent())
		for i in range(3):
			var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_property($pivot/Sprite2D, "self_modulate", Color.WHITE, 0.15)
			tween.tween_property($pivot/Sprite2D, "self_modulate", Color("#00d9ff"), 0.15)
			await tween.finished
