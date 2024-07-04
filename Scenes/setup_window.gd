extends Control

@onready var manager = get_tree().root.get_node("GameManager")

@onready var userLabel = $Window/GridContainer/UserLabel
@onready var hostLabel = $Window/GridContainer/HostLabel
@onready var joinLabel = $Window/GridContainer/JoinLabel
@onready var userText = $Window/GridContainer/UserText
@onready var hostText = $Window/GridContainer/HostText
@onready var joinText = $Window/GridContainer/JoinText

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.game_mode == Global.MODE.HOST:
		showHost()
	elif Global.game_mode == Global.MODE.JOIN:
		showJoin()

func showHost():
	userLabel.show()
	userText.show()
	hostLabel.show()
	hostText.show()

func showJoin():
	userLabel.show()
	userText.show()
	joinLabel.show()
	joinText.show()


func _on_continue_pressed():
	if userText.text.is_empty():
		Network.player_info["name"] = "Anonymous"
	else:
		Network.player_info["name"] = userText.text
		
	if Global.game_mode == Global.MODE.HOST:
		if hostText.text.is_empty():
			Global.host_name = "Host" + str(round(randf_range(100, 999)))
		else:
			Global.host_name = hostText.text
		Network.create_server()
	elif Global.game_mode == Global.MODE.JOIN:
		if joinText.text.is_empty():
			Global.join_server = "localhost"
		else:
			Global.join_server = joinText.text
		Network.join_server()
