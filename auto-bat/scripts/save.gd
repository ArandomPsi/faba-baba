extends Node

const PATH = "user://savefile.json"

func save_game():
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	if file == null:
		push_error("failed to save bru")
		return
	file.store_string(JSON.stringify({"name": global.playername, "high": global.highscore}))
	file.close()
	
func load_game():
	if not FileAccess.file_exists(PATH):
		return
	var file = FileAccess.open(PATH, FileAccess.READ)
	if file == null:
		push_error("failed to load game bru")
		return
	var txt = file.get_as_text()
	file.close()
	var data = JSON.parse_string(txt)
	if data is Dictionary:
		global.playername = data["name"]
		global.highscore = data["high"]
