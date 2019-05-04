extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# add_child(HUD);
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(Global.Player.is_inside_tree() && Global.Player.visible):
		global_position.x = Global.Player.global_position.x# - get_viewport().size.x/2;
		global_position.y = Global.Player.global_position.y#- get_viewport().size.y/2;
	pass
