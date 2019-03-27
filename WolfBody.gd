extends KinematicBody2D

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
var isAggro = false;
var lifePoints = 15;
export (bool) var isAttacking = false;
export (bool) var damaged = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var angleToPlayer = position.angle_to_point(Global.Player.position);
	var distanceToPlayer = (position - Global.Player.position).length();
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
	
		
	if distanceToPlayer <= 500 || isAggro:
		moveAngle = angleToPlayer;
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
		["Down"]:
			animOffset = 1;
			moveAngle = PI/2;
		["Left"]:
			animOffset = 2;
			moveAngle = PI;
		["Up"]:
			animOffset = 3;
			moveAngle = 3*PI/2;
	
	if isMoving || isAggro:
		#frame = anim[int(floor(animationTime/.25))%3 + 3 * animOffset];
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

func aggro(delta):
	var angleToPlayer = position.angle_to_point(Global.Player.position);
	var distanceToPlayer = (position - Global.Player.position).length();
	isAggro = true;
	print(angleToPlayer);
	if (angleToPlayer <= -3*PI/4 || angleToPlayer >= 3*PI/4):
		moveDirection = "Right";
	if (angleToPlayer  <= 3*PI/4 && angleToPlayer >= PI/4):
		moveDirection = "Up";
	if (angleToPlayer <= PI/4 && angleToPlayer >= -PI/4):
		moveDirection = "Left";
	if (angleToPlayer <= -PI/4 && angleToPlayer >= -3*PI/4):
		moveDirection = "Down";
	position -= delta * (movement.rotated(angleToPlayer))
	if distanceToPlayer >= 500:
		isAggro = false;
	
	return;