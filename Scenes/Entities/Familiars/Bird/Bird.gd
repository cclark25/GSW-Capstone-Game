extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var target = null;
var onReturn = false;
export (float) var hoverDistance = 25;
export (int) var speed = 20;
var time = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	position *= 0;
	
	pass

func Send(newTarget):
	assert typeof(newTarget) == typeof(Node2D);
	printerr("Sending...");
	
	visible = true;
	play("default");
	target = newTarget;
	set_process(true);
	onReturn = false;

func Return(newTarget):
	target = newTarget;
	onReturn = true;

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
	
	if(angle.length() > hoverDistance):
		position += angle.normalized() * speed;
		printerr(angle.length());
	else:
		var relAngle = time;
		angle = angle.rotated(PI/2);
		#position += angle.normalized() * speed / 10;
		#printerr(relAngle);
		global_position = target.global_position + Vector2(angle.length(), 0).rotated(relAngle);
		look_at(target.global_position);
		rotate(-PI/2);
	
	
	pass
