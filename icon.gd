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

func get_forward():
	var y = 0;
	var x = 0;
	var cursorAngle = (position - get_viewport().get_mouse_position());
	
	if Input.is_action_pressed('Up'):
        y -= 1
	if Input.is_action_pressed('Down'):
        y += 1
	if Input.is_action_pressed('Left'):
        x += 1
	if Input.is_action_pressed('Right'):
        x -= 1
	
	velocity = cursorAngle * y ;
	velocity += cursorAngle.tangent() * x;
	velocity = velocity.normalized() * speed;
	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	get_forward();
	position += velocity;
	
	pass
