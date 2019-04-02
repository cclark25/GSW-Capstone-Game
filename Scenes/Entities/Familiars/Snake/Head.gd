extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0.0;
var speed = 1;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	disabled = false;
	var f = get_parent().get_node("Animation").frame;
	position = Vector2(1,-4);
	time += speed*delta;
#	match f:
#		0:
#			pass;
#		1:
#			position += Vector2(30, 3);
#		2:
#			position += Vector2(40, 4);
#	position = position.rotated(get_parent().dir * PI/4);
	
	position += Vector2(40, 4) * sin(PI * time / 0.6);
	position = position.rotated(get_parent().dir * PI/4);
	if(time >= 0.6):
		time = 0.0;
		disabled = true;
		set_process(false);
	pass
