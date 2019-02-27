extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animationTime = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	animationTime += delta;
	var anim = Array();
	anim.append(0);
	anim.append(1);
	anim.append(0);
	anim.append(2);
	
	frame = anim[int(floor(animationTime/.15))%4];
	
	#var x = load("res://demo/bin/gdexample.gdns");
	
	pass
