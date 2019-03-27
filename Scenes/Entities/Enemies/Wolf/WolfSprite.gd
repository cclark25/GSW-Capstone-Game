extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dir = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	dir = int(get_parent().get_angle_to(Global.Player.position) / (PI/4));
	
	
	Play(dir, 1);
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func Play(dir, mode):
	play("1" + "." + Global.Directions.keys()[dir]);