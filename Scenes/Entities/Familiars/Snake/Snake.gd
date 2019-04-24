extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (float) var PullSpeed = 1.5;
var dir = 0;
var time = 0.0;
onready var returnPos = position;
var hookedBody = null;
var hookedPos = Vector2(0,0);
var isJumping = false;
var jumpDestination = null;
var jumpOrigin = null;
var launched = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.hookable, true);
	#set_collision_mask_bit(Global.CollisionType.player, false);
	#connect("body_entered", self, "Collide");
	connect("area_entered", self, "Collide");
	connect("body_entered", self, "Collide");
	get_node("Head").disabled = true;
	set_process(false);
	pass

func Collide(body):
	if(body.get_collision_layer_bit(Global.CollisionType.enemy)):
		Damage.DealDamage(5, body, Damage.DamageType.bite, self);
	if(body.get_collision_layer_bit(Global.CollisionType.hookable)):
		Hook(body);
		pass;

func Hook(body):
	get_node("Head").disabled = true;
	get_node("Animation").animation = "Extend";
	get_node("Animation").frame = 2;
	get_node("Animation").stop();
	time = 0.3;
	hookedBody = body;
	hookedPos = (global_position - body.global_position).rotated(-1 * body.rotation);
	
	set_process(true);
	return;

func UnHook():
	get_node("Animation").play("Retract");
	hookedBody = null;
	scale.x = 1;
	set_process(true);
	launched = false;
	EndMove();

func ItemJump():
	if(hookedBody != null && hookedBody.has_method("GetDestination")):
		isJumping = true;
		#jumpDistance = (get_parent().global_position - hookedBody.GetDestination(self));
		jumpOrigin = get_parent().global_position;
		jumpDestination = hookedBody.GetDestination(self);
		time = 0.0;

func Use():
	if(!launched &&hookedBody != null):
		if(hookedBody.get_collision_layer_bit(Global.CollisionType.dragable)):
			hookedBody.apply_impulse(hookedPos, Vector2((scale.x )*1000, 0).rotated(rotation + PI));
			launched = true;
		else:
			UnHook();
		return;
	
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
	get_node("Animation").stop();
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

	if(isJumping):
		var d = -(jumpOrigin - jumpDestination);
		var c = (global_position - jumpDestination).length();
		get_parent().global_position = jumpOrigin + d*sin((PI/2)*time/0.6);
		if(time >= 0.6):
			isJumping = false;
			UnHook();
	
	if(hookedBody != null):
		global_position = hookedBody.global_position + hookedPos.rotated(hookedBody.rotation);
		rotation = (global_position - get_parent().global_position).angle();
		scale.x = position.length() / 40;
		if(scale.x > 2):
			if(!launched && hookedBody.get_collision_layer_bit(Global.CollisionType.dragable)):
				hookedBody.apply_impulse(hookedPos, Vector2((scale.x - 2)*25, 0).rotated(rotation + PI));
			else: 
				UnHook();
		return;
	
	
	position = returnPos + Vector2(40, 0).rotated(rotation) * sin(PI * time / 0.6);
	pass
