extends Node

var http_request := HTTPRequest.new()
const SERVER_URL = "http://localhost:80/godot/db_test.php"
const SERVER_HEADERS = [
	"Content-Type: application/x-www-form-urlencoded",
	"Cache-Control: max-age=0"
]

var request_queue: Array = []
var is_requesting: bool = false

signal highscores_received(scores)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_http_request_completed"))
	print("Highscore system ready.")


func _process(_delta):
	if is_requesting: return
	if request_queue.is_empty(): return
	
	is_requesting = true
	_send_request(request_queue.pop_front())



func _send_request(req: Dictionary):
	var client := HTTPClient.new()
	
	if req["command"] == "getHighscores2":
		emit_signal("highscores_received", [{"name": "SYLV", "score": 50}, {"name": "MAFFE", "score": 1}])
		print("hijacking the leaderboard system rn. check databasehandler line 33")
		is_requesting = false;
		return
	
	var encoded_data = client.query_string_from_dict(req["data"])
	var body = "command=" + req["command"] + "&" + encoded_data
	
	var err = http_request.request(
		SERVER_URL,
		SERVER_HEADERS,
		HTTPClient.METHOD_POST,
		body
	)
	
	if err != OK:
		printerr("HTTPRequest error: " + str(err))
		return
	
	print("Sending request:\n\tCommand: " + req["command"] + "\n\tBody: " + body)


func _http_request_completed(result, response_code, headers, body):
	is_requesting = false
	
	if result != http_request.RESULT_SUCCESS:
		printerr("HTTP error: " + str(result))
		return
	
	var raw = body.get_string_from_utf8()
	print("RAW RESPONSE:", raw) 
	var json = JSON.new()
	json.parse(raw)
	var data = json.get_data()
	
	if data["error"] != "none":
		printerr("Server returned error: " + data["error"])
		return
	
	_handle_response(data)


func add_highscore(score: int, player_name: String):
	request_queue.push_back({
		"command": "addHighscore",
		"data": {
			"name": player_name,
			"score": score
		}
	})

func get_highscores(limit: int = 10, offset: int = 0):
	request_queue.push_back({
		"command": "getHighscores",
		"data": {
			"limit": limit,
			"offset": offset
		}
	})

func get_player(id: int):
	request_queue.push_back({
		"command": "get_player",
		"data": {
			"user_id": id
		}
	})


func _handle_response(data: Dictionary):
	var size = int(data["datasize"])
	var response = data["response"]
	var command = data["command"]
	
	print("-----------------------------------")
	print("Server response:")
	print("Command: ", command)
	print("Datasize: ", size)
	print("Response: ", response)
	print("-----------------------------------")

	if command == "getHighscores" and size > 0:
		var arr := []
		if response is Array:
			arr = response
		elif response is Dictionary:
			arr.append(response)
		
		for item in arr:
			print(item.get("name", "Unknown"), " - ", item.get("score", 0))
		
		emit_signal("highscores_received", arr)
	
	elif command == "addHighscore":
		if response.get("success", false):
			print("Highscore added successfully.")
		else:
			printerr("Failed to add highscore")
