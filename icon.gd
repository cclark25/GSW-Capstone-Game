extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2();
export (int) var speed = 5;
var targeting = false;
var jumpTime = .10;
var jumpElapsed = jumpTime;
var jumpModifier = 15;
var inJump = false;
var forward = 0;
var jDir = Vector2();
var animationTime = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func get_input(delta):
	var y = 0;
	var x = 0;
	var cursorAngle = Vector2();
	cursorAngle = (position - get_viewport().get_mouse_position());
	
	if Input.is_action_pressed('Up'):
        y -= 1
	if Input.is_action_pressed('Down'):
        y += 1
	if Input.is_action_pressed('Left'):
        x += 1
	if Input.is_action_pressed('Right'):
        x -= 1
	
	if (x == y ):
		x *= sqrt(2)/2
		y *= sqrt(2)/2
	
	velocity = cursorAngle * y ;
	velocity = velocity.normalized() * speed;
	position += velocity;
	
	cursorAngle = (position - get_viewport().get_mouse_position());
	var newAngle = 0;
	if (position.distance_to(get_viewport().get_mouse_position()) != 0 ):
		newAngle = -(x * speed)/((get_viewport().get_mouse_position()).distance_to(position)) + cursorAngle.angle();
	var rotOffset = Vector2();
	rotOffset.y = sin(newAngle);
	rotOffset.x = cos(newAngle);
	if(x != 0):
		position = get_viewport().get_mouse_position() + (rotOffset.normalized() * cursorAngle.length());
	
	velocity = get_viewport().get_mouse_position() - position;
	
	
func move_normal(delta):
	var newVelocity = Vector2();
	if Input.is_action_pressed('Up'):
        newVelocity.y -= 1
	if Input.is_action_pressed('Down'):
        newVelocity.y += 1
	if Input.is_action_pressed('Left'):
        newVelocity.x -= 1
	if Input.is_action_pressed('Right'):
        newVelocity.x += 1
	if (newVelocity.length() != 0):
		velocity = newVelocity.normalized() * speed;
		position += velocity;

func jump(delta):	
	
	if !inJump:
		jDir.y = 0;
		jDir.x = 1;
		jDir = jDir.rotated(rotation);
		inJump = true;
		if Input.is_action_pressed("Left"):
			jDir = jDir.rotated(PI/2);
		if Input.is_action_pressed("Right"):
			jDir = jDir.rotated(-PI/2);
		if Input.is_action_pressed("Down"):
			jDir = jDir.rotated(PI);
	
	
	if targeting:
		position += jDir.normalized() * (speed + jumpModifier * sin(PI * jumpElapsed/jumpTime));
	else:
		position += velocity.normalized() * (speed + jumpModifier * sin(PI * jumpElapsed/jumpTime));
	
	jumpElapsed -= delta;
	if jumpElapsed <= 0:
		inJump = false;
		jumpElapsed = jumpTime;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_just_pressed("Target"):
		targeting = !targeting;
	
	
	if Input.is_action_just_pressed("Jump") || inJump:
		jump(delta);
		return;
	
	if targeting: 
		get_input(delta);
	else:
		move_normal(delta);
	
	rotation = velocity.angle();
	printerr(rotation);
	var dir = 0;
	if( rotation > 0 ):
		dir = 0
	if( rotation > PI/4):
		dir = 1
	if( rotation > PI/2):
		dir = 2
	if( rotation > 3*PI/4):
		dir = 3
	if( rotation > PI):
		dir = 4
	if( rotation < -PI/4):
		dir = 7
	if( rotation < -PI/2):
		dir = 6
	if( rotation < -3*PI/4):
		dir = 5
	if( rotation > 2*PI):
		dir = 0
	rotation = 0
	animationTime += delta;
	if(velocity.length() > 0):
		frame = 3*dir + int(floor(animationTime/.15))%3
	else:
		frame = 3*dir
	velocity *= 0;
	pass
