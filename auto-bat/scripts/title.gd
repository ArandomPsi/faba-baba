extends Control

var ogshippos : Vector2

@onready var simpleboards = $SimpleBoardsApi

func _ready() -> void:
	ogshippos = $ship.position
	
	#annoying popup
	if global.playername == "":
		while global.playername == "":
			$entername.visible = true
			await $entername.text_submitted
			$entername.visible = false
			global.playername = $entername.text
			$entername.release_focus()
	
	print(str(global.playername))
	 
	
	# Set the API key (from your SimpleBoards dashboard)
	simpleboards.set_api_key("7499c2ec-05a7-4f87-8cc0-e90f6cc0baae")

	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	simpleboards.entry_sent.connect(_on_entry_sent)
	simpleboards.request_failed.connect(_on_request_failed)
	
	
	if global.transferscore > 0:
		await simpleboards.send_score_without_id("533cfd29-3759-446d-24b1-08df32091af1",global.playername,str(global.transferscore),"{}")
	
	global.transferscore = 0
	
	
	
	

	
	
	# Fetch leaderboard entries
	await simpleboards.get_entries("533cfd29-3759-446d-24b1-08df32091af1")
	


func _process(delta: float) -> void:
	shipstuff()
	
	if Input.is_action_just_pressed("test"):
		test()
	

func shipstuff():
	$ship.position = lerp($ship.position,ogshippos + Vector2(randf_range(-1,1),randf_range(-1,1)) * 30,0.05)

func test():
	await simpleboards.send_score_without_id("533cfd29-3759-446d-24b1-08df32091af1",global.playername,str(global.transferscore),"{}")

func _on_entries_got(entries):
	var label = $scoreboard/RichTextLabel
	label.clear()

	for i in range(entries.size()):
		var entry = entries[i]
		label.append_text(str(i + 1) + ": " +str(entry["playerDisplayName"]) + " - " +str(entry["score"]) + "%\n")

func _on_entry_sent(entry):
	print("Score submitted: ", entry)
	await simpleboards.get_entries("533cfd29-3759-446d-24b1-08df32091af1")

func _on_request_failed(response_code, body):
	push_warning("SimpleBoards request failed: %s - %s" % [response_code, body])


func _on_button_2_pressed() -> void:
	var tween = create_tween()
	tween.tween_property($scoreboard,"position",Vector2(803.0,204),0.5).set_trans(Tween.TRANS_CUBIC)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/testmap.tscn")
