extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Player = preload("res://Scenes/Entities/Player/Player.tscn").instance();


enum Directions { Right, DownRight, Down, DownLeft, Left, UpLeft, Up, UpRight }


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func store_player(player):
	#if(playerStorage == null):
	#	playerStorage = player;
	#else:
	#	printerr("Error: playerStorage is ");
	pass

func retrieve_player():
	#return playerStorage;
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
