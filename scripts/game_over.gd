extends Control

@onready var leaderboard_container := $red_abov/Margins/ContentHolder/Leaderboard

func _ready() -> void:
	DatabaseHandler.connect("highscores_received", Callable(self, "_on_highscores_received"))
	DatabaseHandler.get_highscores(10, 0)
	fade_in()

func fade_in():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1), 0.5)


func _on_highscores_received(scores: Array):

	for score_entry in scores:
		var playername = score_entry.get("name", "Unknown")
		var score = score_entry.get("score", 0)
		
		var label = Label.new()
		label.text = playername + " - " + str(score)
		leaderboard_container.add_child(label)
		
	print("Leaderboard updated!")
