extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _pressed():
	Global.spawned = [];
	Global.Player = load("res://Scenes/Entities/Player/Player.tscn").instance();
	Global.set_current_scene("start_menu");
	Global.SpawnNode(Global.Player);
	return;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
