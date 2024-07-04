extends Control

@onready var manager = get_tree().root.get_node("GameManager")


func _on_host_pressed():
	Global.game_mode = Global.MODE.HOST
	manager.change_scene(Global.setup_window)


func _on_join_pressed():
	Global.game_mode = Global.MODE.JOIN
	manager.change_scene(Global.setup_window)


func _on_dedicated_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()


func _on_level_test_pressed():
	manager.change_scene(Global.test_level)
