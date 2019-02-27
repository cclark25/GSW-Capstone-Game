extends Sprite
var animationTime = 0;
var waitTime = 5;
var flightTime = 1;
var inFlight = false;
var movement = Vector2();
var moveAngle = 0;
var lifePoints = 5;
var damaged = false;
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	animationTime += delta;
	
	if(damaged):
		var tmp = 2 + sin((animationTime - floor(animationTime))*2*PI);
		self_modulate.r *= tmp;
		if(animationTime >= .15):
			damaged = false;
			if(lifePoints > 0): self_modulate.r = 1;
			animationTime = 0;
		return;
	
	if(lifePoints <= 0):
		var tmp = animationTime / .15;
		self_modulate.a *= tmp;
		if(animationTime >= .15):
			queue_free();
		return;
	
	if(animationTime / waitTime >= 1 && !inFlight):
		inFlight = true;
		animationTime = 0;
		var angle = position.angle_to_point(get_parent().get_child(0).position);# (((randi()%180)/180) * PI)
		var distance = (position - get_parent().get_child(0).position).length();
		movement = Vector2(max(distance * 1.5, 300), 0);
		moveAngle = (randf() * PI/4) - PI/8;
		movement = movement.rotated(angle);
	
	if(inFlight):
		position -= delta * (movement.rotated(moveAngle * 2*sin(2*PI * (animationTime/flightTime)))) ;
		frame = int(floor(animationTime/.15))%2 + 1;
	
	if(animationTime/flightTime >= 1):
		inFlight = false;
		frame = 0;
	
	pass
