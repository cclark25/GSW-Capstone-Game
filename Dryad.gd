extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animationTime = 0;
var moveAngle = 0;
var waitTime = 5;
var moveDirection = "Right";
var animOffset = 0;
var isMoving = true;
var movement = Vector2(90,0);
var inSlash = false;
var isAggro = false;
var lifePoints = 20;
export (bool) var damaged = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	animationTime += delta;
	var anim = Array();
	anim.append(0);
	anim.append(1);
	anim.append(2);
	anim.append(3);
	anim.append(4);
	anim.append(5);
	anim.append(6);
	anim.append(7);
	anim.append(8);
	anim.append(9);
	anim.append(10);
	anim.append(11);
	
	if (position - get_parent().get_child(0).position).length() <= 150 || inSlash:
		slash(delta);
		
	if (position - get_parent().get_child(0).position).length() <= 500 || isAggro:
		aggro(delta);
		
	
	if (animationTime/waitTime >= 1 && !isAggro):
		isMoving = !isMoving;
		animationTime = 0;
		if isMoving:
			if (moveDirection == "Right"):
				moveDirection = "Left";
			elif (moveDirection == "Left"):
				moveDirection = "Down";
			elif (moveDirection == "Down"):
				moveDirection = "Up";
			else: moveDirection = "Right";
	
	
	match [moveDirection]:
		["Right"]:
			animOffset = 0;
			moveAngle = 0;
			get_child(1).position = Vector2(5,15);
		["Down"]:
			animOffset = 1;
			moveAngle = PI/2;
			get_child(1).position = Vector2(5,20);
		["Left"]:
			animOffset = 2;
			moveAngle = PI;
			get_child(1).position = Vector2(-5,15);
		["Up"]:
			animOffset = 3;
			moveAngle = 3*PI/2;
			get_child(1).position = Vector2(0,-20);
	
	if isMoving || isAggro:
		frame = anim[int(floor(animationTime/.25))%3 + 3 * animOffset];
		position += delta * (movement.rotated(moveAngle));


func Damage(amount, sourceLocation):
	if(!damaged):
		damaged = true;
		animationTime = 0;
		lifePoints -= amount;
		if(lifePoints <= 0):
			self_modulate.b = 4;
		position += (position - sourceLocation ).normalized() * 75;
	pass
		

func slash(delta):
	if !inSlash:
		inSlash = true;
		animationTime = 0;
		get_child(1).show();
	var baseDir = animOffset * PI/2 - PI/4;
	get_child(1).rotation = baseDir;
	if(cos(baseDir) < 0 && int(cos(baseDir)) != 0):
		get_child(1).rotation *= -1;
	
	
	if(cos(baseDir) < 0 && int(cos(baseDir)) != 0):
		get_child(1).rotation -= (PI/2)*animationTime / .25;
	else:
		get_child(1).rotation += (PI/2)*animationTime / .25;
		
	if animationTime / .25 >= 1:
		inSlash = false;
		get_child(1).hide();
		return;

func aggro(delta):
	isAggro = true;
	var angle = position.angle_to_point(get_parent().get_child(0).position);
	print(angle);
	if (angle <= -3*PI/4 || angle >= 3*PI/4):
		moveDirection = "Right";
	if (angle  <= 3*PI/4 && angle >= PI/4):
		moveDirection = "Up";
	if (angle <= PI/4 && angle >= -PI/4):
		moveDirection = "Left";
	if (angle <= -PI/4 && angle >= -3*PI/4):
		moveDirection = "Down";
	var distance = (position - get_parent().get_child(0).position).length();
	position -= delta * (movement.rotated(angle))
	if (position - get_parent().get_child(0).position).length() >= 500:
		isAggro = false;
	
	return;
