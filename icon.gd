extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2();
export (int) var speed = 5;
var targeting = false;
var jumpTime = .25;
var inJump = false;
var forward = 0;

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
		inJump = true;
		forward = !Input.is_action_pressed("Down");
	
	if targeting:
		var x = 1;
		if !forward:
			x = -1;
		printerr(x);
		position += velocity.normalized() * speed * (1 + sin(PI * jumpTime/0.25)) * x;
	else:
		position += velocity.normalized() * speed * (1 + sin(PI * jumpTime/0.25));
	
	jumpTime -= delta;
	if jumpTime <= 0:
		inJump = false;
		jumpTime = .25;

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
	
	pass
