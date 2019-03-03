extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	var f = int(time/.07) % 6;
	if(f < 3):
		frame = f;
	else:
		frame = 2 - f%3;
	pass
