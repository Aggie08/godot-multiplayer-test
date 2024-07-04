extends Node

#Scenes
const test_level = "res://Scenes/Levels/test_level.tscn"
const online_level = "res://Scenes/Levels/test_multiplayer_level.tscn"
const setup_window = "res://Scenes/setup_window.tscn"
const main_menu = "res://Scenes/Menus/main_menu.tscn"

#Variables
var host_name
var host_server = "localhost"
var join_server = "localhost"
var server_port = 445
const server_player_limit = 10
enum MODE {HOST, JOIN}
var game_mode

#User Variables


#Music
const test_song = "res://Assets/Audio/Songs/time_for_adventure.mp3"
