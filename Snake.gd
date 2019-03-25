extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0;
var destination = Vector2();
var hooked = false;
var inJump = false;
var jumpRatio;
var jumpDir = Vector2();

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	get_child(0).get_child(0).disabled = true;
	pass

func Jump():
	if(hooked):
		inJump = true;
		jumpRatio = scale.x;
		jumpDir = -(get_parent().get_parent().position - destination).normalized();
	return hooked;

func Use():
	UnHook();
	set_process(true);
	time = 0;
	visible = true;
	var cursorAngle = Vector2(1,0);
	cursorAngle = cursorAngle.rotated(((get_parent().frame / 3) % 8) * PI/4).rotated(PI) #(get_parent().get_parent().position - get_viewport().get_mouse_position()).normalized();
	cursorAngle *= 41;
	destination = get_parent().get_parent().position - cursorAngle;
	get_child(0).get_child(0).disabled = false;
	pass;

func Hook():
	#destination = spot;
	hooked = true;
	time = 0;
	pass;
	
	
func UnHook():
	hooked = false
	time = 0;
	set_process(false);
	get_child(0).get_child(0).disabled = true;
	visible = false;
	scale.x = 1;
	pass;

func _input(event):
	if(event.is_action("DEBUG")):
		Hook(destination);

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	var f = int(time / .05);
	rotation = (-get_parent().get_parent().position + destination).angle();
	
	if(inJump):
		get_parent().get_parent().position += jumpDir*5;
		if(scale.x > abs(jumpRatio)):
			printerr("Jump Completed");
			inJump = false;
			UnHook();
	
	#get_parent().get_parent().get_parent().get_child(4).position = destination;
	if(hooked):
		scale.x = (get_parent().get_parent().position.distance_to(destination) / 41);
		frame = 3;
		if(scale.x > 3):
			UnHook();
		return;
	
	position = Vector2( 10*sin(f*PI/8) , 10 );
	if(cos(rotation) < 0):
		position.x *= -1;
	
	if(f / 4 < 1):
		frame = f;
	else:
		frame = 3 - f%4;
	if(f > 7):
		visible = false;
		set_process(false);
		position = Vector2(0, 10);
		scale.x = 1;
		get_child(0).get_child(0).disabled = true;
	
	match frame:
		0:
			get_child(0).get_child(0).position = Vector2(10,-4);
		1:
			get_child(0).get_child(0).position = Vector2(31,-1);
		2:
			get_child(0).get_child(0).position = Vector2(41,0);
		3:
			get_child(0).get_child(0).position = Vector2(41,0);
	pass
