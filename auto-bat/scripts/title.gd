extends Control

var ogshippos : Vector2

@onready var simpleboards = $SimpleBoardsApi

func _ready() -> void:
	ogshippos = $ship.position
	
	# Set the API key (from your SimpleBoards dashboard)
	simpleboards.set_api_key("YOUR_API_KEY")

	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	simpleboards.entry_sent.connect(_on_entry_sent)
	simpleboards.request_failed.connect(_on_request_failed)
	
	 # Send scores (with and without explicit player ID)
	await simpleboards.send_score_without_id(
		"YOUR_LEADERBOARD_ID",
		"PlayerName",
		"12345",        # score as string
		"[]"            # metadata as string (e.g. JSON)
	)

	await simpleboards.send_score_with_id(
		"YOUR_LEADERBOARD_ID",
		"PlayerName",
		"12345",
		"[]",
		"player-id-1"   # stable player ID
	)

	# Fetch leaderboard entries
	await simpleboards.get_entries("YOUR_LEADERBOARD_ID")


func _process(delta: float) -> void:
	shipstuff()

func shipstuff():
	$ship.position = lerp($ship.position,ogshippos + Vector2(randf_range(-1,1),randf_range(-1,1)) * 30,0.05)


func _on_entries_got(entries):
	for entry in entries:
		print(entry)

func _on_entry_sent(entry):
	print("Entry sent:", entry)

func _on_request_failed(response_code, body):
	push_warning("SimpleBoards request failed: %s - %s" % [response_code, body])
