extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2();
export (int) var speed = 7;
var targeting = false;
var jumpTime = .30;
var jumpElapsed = jumpTime;
var jumpModifier = 5;
var inJump = false;
var forward = 0;
var jDir = Vector2();
var animationTime = 0;
var isMoving = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func get_input(delta):
	var y = 0;
	var x = 0;
	var cursorAngle = Vector2();
	cursorAngle = (position - get_viewport().get_mouse_position());
	isMoving = false;
	if Input.is_action_pressed('Up'):
		y -= 1
		isMoving = true;
	if Input.is_action_pressed('Down'):
		y += 1
		isMoving = true;
	if Input.is_action_pressed('Left'):
		x += 1
		isMoving = true;
	if Input.is_action_pressed('Right'):
		x -= 1
		isMoving = true;
	
	if (x == y ):
		x *= sqrt(2)/2
		y *= sqrt(2)/2
	
	velocity = cursorAngle * y ;
	velocity = velocity.normalized() * speed * delta / .015;
	if(y > 0 || position.distance_to(get_viewport().get_mouse_position()) > velocity.length()):
		position += velocity;
	
	cursorAngle = (position - get_viewport().get_mouse_position());
	var newAngle = 0;
	if (position.distance_to(get_viewport().get_mouse_position()) != 0 ):
		newAngle = -(x * speed * delta / .015)/((get_viewport().get_mouse_position()).distance_to(position)) + cursorAngle.angle();
	var rotOffset = Vector2();
	rotOffset.y = sin(newAngle);
	rotOffset.x = cos(newAngle);
	if(x != 0):
		position = get_viewport().get_mouse_position() + (rotOffset.normalized() * cursorAngle.length());
	
	velocity = get_viewport().get_mouse_position() - position;
	
	
func move_normal(delta):
	var newVelocity = Vector2();
	isMoving = false;
	if Input.is_action_pressed('Up'):
		newVelocity.y -= 1
		isMoving = true;
	if Input.is_action_pressed('Down'):
		newVelocity.y += 1
		isMoving = true;
	if Input.is_action_pressed('Left'):
		newVelocity.x -= 1
		isMoving = true;
	if Input.is_action_pressed('Right'):
		newVelocity.x += 1
		isMoving = true;
	if (newVelocity.length() != 0):
		velocity = newVelocity.normalized() * speed * delta / .015;
		position += velocity;
	

func jump(delta):	
	
	if !inJump:
		jDir.y = 0;
		jDir.x = 1;
		jDir = jDir.rotated(velocity.angle());
		inJump = true;
		if(targeting):
			if Input.is_action_pressed("Left"):
				jDir = jDir.rotated(PI/2);
			if Input.is_action_pressed("Right"):
				jDir = jDir.rotated(-PI/2);
			if Input.is_action_pressed("Down"):
				jDir = jDir.rotated(PI);
			
		
	
	var jFrame = 0;
	if (jumpElapsed/jumpTime <= .667):
		jFrame = 1;
	if (jumpElapsed/jumpTime <= .333):
		jFrame = 2;
	if (jumpElapsed/jumpTime <= 0):
		jFrame = 0;
	
	
	if targeting:
		var tmp = jDir.normalized() * ((speed * delta / .015) + jumpModifier * sin(PI * jumpElapsed/jumpTime));
		if(position.distance_to(get_viewport().get_mouse_position()) > tmp.length()):
			position += tmp;
		
		
	else:
		position += velocity.normalized() * ((speed * delta / .015) + jumpModifier * sin(PI * jumpElapsed/jumpTime));
	
	frame = 24 + 3*GetDir(jDir.angle()) + jFrame;
	
	jumpElapsed -= delta;
	if jumpElapsed <= 0:
		inJump = false;
		jumpElapsed = jumpTime;

func GetDir(var angle):
	var dir = 0;
	if( angle > 0 ):
		dir = 0
	if( angle > PI/8):
		dir = 1
	if( angle > 3*PI/8):
		dir = 2
	if( angle > 5*PI/8):
		dir = 3
	if( angle > 7*PI/8):
		dir = 4
	if( angle < -PI/8):
		dir = 7
	if( angle < -3*PI/9):
		dir = 6
	if( angle < -5*PI/8):
		dir = 5
	if( angle < -7*PI/8):
		dir = 4
	return dir;

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
	
	
	var dir = GetDir(rotation);
	rotation = 0
	animationTime += delta;
	var anim = Array();
	anim.append(0);
	anim.append(1);
	anim.append(0);
	anim.append(2);
	
	if(isMoving):
		frame = 3*dir + anim[int(floor(animationTime/.15))%4];
	else:
		frame = 3*dir
	
	
	pass
