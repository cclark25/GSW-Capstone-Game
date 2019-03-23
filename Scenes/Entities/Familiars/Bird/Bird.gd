extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var target = null;
var onReturn = false;
var onSend = false;
export (float) var hoverDistance = 25;
export (int) var speed = 400;
var time = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	visible = false;
		
	pass

func Send(to, from):
	assert typeof(to) == typeof(Node2D);
	if(!onSend && !onReturn):
		global_position = from.global_position;
	visible = true;
	play("default");
	target = to;
	set_process(true);
	onReturn = false;
	onSend = true;

func Return(to, from):
	target = to;
	onReturn = true;
	onSend = false;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.	
	time += delta;
	var angle = (target.global_position - global_position);
	
	if(onReturn && angle.length() < hoverDistance):
		visible = false;
		set_process(false);
		stop();
		return;
		
	look_at(target.global_position);
	if(angle.length() > hoverDistance):
		global_position += angle.normalized() * speed * delta;
	else:
		var relAngle = time;
		angle = angle.rotated(PI/2);
		#position += angle.normalized() * speed / 10;
		#printerr(relAngle);
		#global_position = target.global_position + Vector2(1, 0).rotated(relAngle).normalized()*hoverDistance;
		global_position += angle.normalized()*speed*delta;
		rotate(PI/2);
	
	
	pass
