extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2();
export (int) var speed = 10;

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
	printerr(newAngle);
	if(x != 0):
		position = get_viewport().get_mouse_position() + (rotOffset.normalized() * cursorAngle.length());
	rotation = newAngle;
	
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	get_input(delta);
	pass
