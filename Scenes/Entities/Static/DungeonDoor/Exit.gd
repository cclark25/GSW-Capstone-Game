extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tmp = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if(!is_connected("body_exited", self, "exit")): connect("body_exited", self, "exit");
	set_collision_mask_bit(Global.CollisionType.player, true);
	get_node("ExitTrigger").disabled = false;
	#tmp = false;
	#printerr(get_overlapping_bodies());
	pass
	
func _input(event):
	if(event.is_action_pressed("DEBUG")):
		printerr(get_overlapping_bodies());
		pass;
	return;
	
func exit(body):
	#get_node("ExitTrigger").disabled = true;
	#if(tmp): return;
	#tmp = true;
	printerr("Door: " + get_parent().doorId + "\tScene: " + get_parent().exitScene);
	var x = Global.Player.global_position - $ExitTrigger.global_position;
	x = x.rotated(-global_rotation);
	if(x.y < 0):
		Global.currentSet.SetScene(get_parent().exitScene);
	
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
