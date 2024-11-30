extends Node2D

@onready var music_player = $MusicPlayer
@onready var scene = $Scene

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.stream = load(Global.test_song)
	music_player.play()

func change_song(song: String):
	if music_player.stream.resource_path == song:
		pass
	else:
		music_player.stream = load(song)
		music_player.play()

func change_scene(new_scene: String):
	if scene.get_child(0):
		scene.get_child(0).queue_free()
	scene.add_child(load(new_scene).instantiate())

func spawn_player(player):
	await get_tree().create_timer(0.5).timeout
	var level = scene.get_child(0).get_node("SpawnPoint")
	
	level.add_child(player)

func remove_player(player):
	var level = scene.get_child(0).get_node("SpawnPoint")
	level.find_child(player).queue_free()
