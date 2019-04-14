extends Sprite
var animationTime = 0;
var waitTime = 5;
var flightTime = 1;
var inFlight = false;
var movement = Vector2();
var moveAngle = 0;
var lifePoints = 5;
var damaged = false;
var targetBody = Global.Player;
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
			Global.GetDoor("North").unlock();
			get_parent().queue_free();
		return;
	
	if(animationTime / waitTime >= 1 && !inFlight):
		inFlight = true;
		animationTime = 0;
		var angle;
		if(targetBody != null):
			angle = get_parent().global_position.angle_to_point(targetBody.global_position);# (((randi()%180)/180) * PI)
		else:
			angle = ((randi()%180)/180) * PI;
		
		var distance = 8;
		if (targetBody != null):
			distance = (get_parent().global_position - targetBody.global_position).length();
		
		movement = Vector2(max(distance * 1.5, 300), 0);
		moveAngle = (randf() * PI/4) - PI/8;
		movement = movement.rotated(angle);
	
	if(inFlight):
		get_parent().global_position -= delta * (movement.rotated(moveAngle * 2*sin(2*PI * (animationTime/flightTime)))) ;
		frame = int(floor(animationTime/.15))%2 + 1;
	
	if(animationTime/flightTime >= 1):
		inFlight = false;
		frame = 0;
	
	pass
