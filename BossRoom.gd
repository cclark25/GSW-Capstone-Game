extends WorldEnvironment

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _init():
	printerr("Initialized!");

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#var player = Global.retrieve_player();
	
	#Global.Player.owner = self;
	#Global.Player.set_position(get_child(2).position);
	#Global.Player.show();
	
	#get_child(1).lock();
	printerr(get_child(2).name);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
