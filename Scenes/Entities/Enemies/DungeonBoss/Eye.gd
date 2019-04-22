extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animationTime = 0;
export (float) var closedTime = 5;
export (float) var openTime = 2;

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
	
	#frame = anim2[int(floor(animationTime/.15))%4];
	
	if(animationTime >= closedTime && animationTime <= closedTime + .45):
		frame = anim[int(floor((animationTime - closedTime)/.15))%3];
	if(animationTime >= closedTime + openTime && animationTime <= closedTime + openTime + .45):
		frame = 2 - anim[int(floor((animationTime - closedTime - openTime)/.15))%3];
	if(animationTime >= closedTime + openTime + .45):
		frame = 0;
		animationTime = 0;
	
	pass
