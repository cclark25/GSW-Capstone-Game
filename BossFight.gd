extends WorldEnvironment

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
	var sword = preload("Scenes/Entities/Items/PlayerSword/Sword.tscn").instance();
	add_child(sword);
	sword.visible = false;
	sword.global_position = Vector2(100,100);
	Global.Player.AddItem(sword);
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	if(time >= 5):
		#get_child(1).unlock();
		#add_child(preload("res://Scenes/Entities/Enemies/Katydid/Katydid.tscn").instance());
		#set_process(false);
		Global.set_current_scene("demo_BossRoom");
		time = 0;
	pass
