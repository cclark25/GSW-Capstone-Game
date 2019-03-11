extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animationTime = 0;
export (int) var speed = 10;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	animationTime += delta;
	
	var anim = Array();
	anim.append(0);
	anim.append(1);
	anim.append(0);
	anim.append(2);
	frame = anim[int(floor(animationTime/.15))%4];
	if(get_parent().get_child(1).targeting):
		
		visible = true;
		var curPosition = (get_viewport().get_mouse_position() - get_parent().position) ;
		rotation = curPosition.angle_to_point(position);
		var velocity = Vector2((delta/.01)*speed, 0);
		
		if(curPosition.distance_to(position) < 25):
			rotation += PI/2;
			velocity = velocity.normalized() * (delta / .01) * speed / 4;
	
		velocity = velocity.rotated(rotation);
		position += velocity;
	else:
		position *= 0;
		visible = false;
	
	pass
