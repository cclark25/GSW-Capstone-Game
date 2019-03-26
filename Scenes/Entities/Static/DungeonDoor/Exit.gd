extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tmp = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("body_exited", self, "exit");
	set_collision_mask_bit(Global.CollisionType.player, true);
	#get_node("ExitTrigger").disabled = false;
	#tmp = false;
	#printerr(get_overlapping_bodies());
	pass
	
func _input(event):
	if(event.is_action_pressed("DEBUG")):
		printerr(get_overlapping_bodies());
		pass;
	return;
	
func exit(body):
	disconnect("body_exited", self, "exit");
	#get_node("ExitTrigger").disabled = true;
	#if(tmp): return;
	#tmp = true;
	
	
	if(body == Global.Player ):
		Global.set_current_scene(get_parent().exitScene, get_parent());
	
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
