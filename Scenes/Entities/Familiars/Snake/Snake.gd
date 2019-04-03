extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dir = 0;
var time = 0.0;
onready var returnPos = position;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.hookable, true);
	#set_collision_mask_bit(Global.CollisionType.player, false);
	#connect("body_entered", self, "Collide");
	connect("area_entered", self, "Collide");
	get_node("Head").disabled = true;
	set_process(false);
	pass

func Collide(body):
	if(body.get_collision_layer_bit(Global.CollisionType.enemy)):
		body.TakeDamage(5, self);
	if(body.get_collision_layer_bit(Global.CollisionType.hookable)):
		printerr("Snake Collided with Hookable!");
		pass;

func Use():
	if(get_parent() == Global.Player && Global.Player.isTargeting()):
		var angle = (-Global.Player.global_position + get_global_mouse_position()).angle();
#		dir = int(angle / (PI/4));
#		if(dir < 0):
#			dir += 8;
#		var direction = dir * (PI/4);
#		if(direction > PI):
#			direction -= 2*PI;
#		angle -= direction;
		rotation = angle;
	else:
		rotation = get_parent().get_direction() * (PI/4);
	
	visible = true;
	get_node("Animation").Play(get_node("Animation").Extend);
	get_node("Head").disabled = false;
	#set_process(true);
	return;

func EndMove():
	visible = false;
	set_process(false);
	get_node("Head").disabled = true;
	time = 0.0;

func frameChange():
	var f = get_node("Animation").frame;
	if(get_node("Animation").animation == "Extend"):
		position = returnPos + Vector2(40, 0).rotated(rotation) * (f/2.0);
	elif(get_node("Animation").animation == "Retract"):
		position = returnPos + Vector2(40, 0).rotated(rotation) * ((2-f)/2.0);
	return;

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	printerr(get_node("Head").disabled);
	time += delta;
	position = returnPos + Vector2(40, 0).rotated(rotation) * sin(PI * time / 0.6);
	pass
