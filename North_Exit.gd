extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("body_entered", self, "exit");
	pass

func exit(body):
	if(body == get_parent().get_parent().get_child(3)):
		var player = get_tree().current_scene.get_child(3);
		get_tree().current_scene.remove_child(player);
		Global.store_player(player);
		get_tree().change_scene("res://BossRoom.tscn");
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
