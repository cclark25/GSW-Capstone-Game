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
	anim.append(2);
	anim.append(3);
	anim.append(4);
	anim.append(5);
	anim.append(6);
	anim.append(7);
	anim.append(8);
	anim.append(9);
	anim.append(10);
	anim.append(11);
	
	frame = anim[int(floor(animationTime/.25))%12];

