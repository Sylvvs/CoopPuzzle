extends Control

@onready var leaderboard_element = preload("res://scenes/UI Elements/leaderboard_element.tscn")
@onready var red_abov := $red_abov
@onready var margins := $red_abov/Margins
@onready var red := $red_abov/Red
@onready var leaderboard_container := $red_abov/Margins/ContentHolder/Leaderboard
@onready var namefield := $red_abov/Margins/ContentHolder/SubmitScore/NameField
@onready var submitbut := $red_abov/Margins/ContentHolder/SubmitScore/Submit
@onready var retry := $red_abov/Margins/ContentHolder/Retry

func _ready() -> void:
	red_abov.visible = false
	DatabaseHandler.connect("highscores_received", Callable(self, "_on_highscores_received"))
	DatabaseHandler.get_highscores(10, 0)


func fade_in():
	get_tree().paused = true;
	red_abov.visible = true
	margins.modulate.a = 0.0
	red.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(margins, "modulate", Color(1.0, 1.0, 1.0, 1), 0.5)
	tween.parallel().tween_property(red, "modulate", Color(1.0, 1.0, 1.0, 1), 0.5)


func _on_highscores_received(scores: Array):

	for score_entry in scores:
		var playername = score_entry.get("name", "Unknown")
		var score = score_entry.get("score", 0)
		
		var element = leaderboard_element.instantiate()
		var container = element.get_node("PanelContainer").get_node("HBoxContainer")
		
		var total_seconds = int(score)
		var displayed_minutes = total_seconds / 60.0
		var displayed_seconds = total_seconds % 60
		container.get_node("Name").text = playername
		container.get_node("Score").text = "%02d:%02d" % [displayed_minutes, displayed_seconds]
		leaderboard_container.add_child(element)

func show_warning():
	submitbut.text = "SET A NAME"
	
	if submitbut.has_meta("fade_tween"):
		var old = submitbut.get_meta("fade_tween")
		if old.is_valid():
			old.kill()

	var tween = create_tween()
	submitbut.set_meta("fade_tween", tween)
	
	tween.tween_property(submitbut, "modulate", Color(1,1,1), 1)
	tween.tween_callback(func(): submitbut.text = "SUBMIT SCORE")

func _on_submit_pressed() -> void:
	if namefield.text == "":
		show_warning()
	
	var text = namefield.text.to_upper()
	var score = get_parent().get_node("lbl_timer").time_elapsed
	DatabaseHandler.add_highscore(int(score), text)
