extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	
	#if(Global.get_current_scene() == null):
	#	Global.set_current_scene("demo_BossFight");
	
	#var d = Global.GetDoor("North", self);
	#d.exitScene = "demo_BossRoom";
	#d.exitTo = "South";
#	var w = Global.GetDoor("West", self);
#	var e = Global.GetDoor("East", self);
#	w.visible = false;
#	e.visible = false;
	pass

func handleDeath(body):
	#Global.GetDoor("North", self).unlock();
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	
	pass
