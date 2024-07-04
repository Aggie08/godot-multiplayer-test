extends Node

var player_scene: PackedScene = load("res://Scenes/online_player.tscn")
var players = {}
var player_info = {}

@onready var manager = get_tree().root.get_node("GameManager")

func _ready():
	multiplayer.connected_to_server.connect(_on_server_connected)
	multiplayer.connection_failed.connect(_on_connection_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func create_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(Global.server_port, 10)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
	var host_id = multiplayer.get_unique_id()
	load_game()
	add_player(host_id)

func join_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(Global.join_server, Global.server_port)
	multiplayer.multiplayer_peer = peer

func add_player(id):
	var player = player_scene.instantiate()
	var new_player_info = {"id": id}
	player.name = str(id)
	if multiplayer.is_server():
		new_player_info.isHost = true
	else:
		new_player_info.isHost = false
	players[id] = new_player_info
	manager.spawn_player(player)

func load_game():
	manager.change_scene(Global.online_level)

func get_IP():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip

func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null

func is_user_host(id):
	return players[id].isHost

#A player connects to the server
func _on_player_connected(id):
	if multiplayer.is_server():
		print("Host connected!")
	else:
		print("player " + str(id) + " connected!")
	add_player(id)

#A player disconnected
func _on_player_disconnected(id):
	print("Player " + str(id) + " disconnected!")
	if not multiplayer.is_server():
		multiplayer.multiplayer_peer.disconnect_peer(1)
	players.erase(id)
	manager.remove_player(str(id))

#When you join a server
func _on_server_connected():
	print("Connected to server")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	load_game()

#When you fail to join a server
func _on_connection_fail():
	print("Connection to server failed")
	remove_multiplayer_peer()

#The server disconnects
func _on_server_disconnected():
	print("Server disconnected")
	multiplayer.multiplayer_peer = null
	players.clear()
	manager.change_scene()
