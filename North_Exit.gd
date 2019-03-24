extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("body_entered", self, "exit");
	set_collision_mask_bit(Global.CollisionType.player, true);
	get_node("CollisionShape2D").disabled = false;
	pass

func exit(body):
	disconnect("body_entered", self, "exit");
	printerr(Global.Player.name);
	if(body == Global.Player):
		Global.set_current_scene("demo_BossRoom");
		
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
