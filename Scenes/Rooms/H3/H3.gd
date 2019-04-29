extends WorldEnvironment

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var sword = load("Scenes/Entities/Items/PlayerSword/Sword.tscn").instance();
	var snake = load("res://Scenes/Entities/Familiars/Snake/Snake.tscn").instance();
	#add_child(sword);
	
	sword.visible = false;
	sword.global_position = Vector2(100,100);
	snake.visible = false;
	snake.global_position = Vector2(100,100);
	
	Global.Player.AddItem(sword);
	Global.Player.AddItem(snake);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
