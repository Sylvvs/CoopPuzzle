extends Button
var scene_handler
func _ready(): 
	scene_handler = get_tree().root.get_node("SceneHandler")

func _on_pressed() -> void:
	scene_handler.load_scene("testlevel")
