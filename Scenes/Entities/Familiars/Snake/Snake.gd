extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dir = 0;
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.hookable, true);
	set_collision_mask_bit(Global.CollisionType.player, false);
	connect("body_entered", self, "Collide");
	connect("area_entered", self, "Collide");
	pass

func Collide(body):
	printerr(body);
	if(body.get_collision_layer_bit(Global.CollisionType.enemy)):
		body.TakeDamage(5, global_position);
	if(body.get_collision_layer_bit(Global.CollisionType.hookable)):
		pass;

func Use():
	if(get_parent() == Global.Player && Global.Player.isTargeting()):
		var angle = (-Global.Player.global_position + get_global_mouse_position()).angle();
		dir = int(angle / (PI/4));
		if(dir < 0):
			dir += 8;
		var direction = dir * (PI/4);
		if(direction > PI):
			direction -= 2*PI;
		angle -= direction;
		rotation = angle;
	else:
		dir = get_parent().get_direction();
	
	visible = true;
	get_node("Animation").Play(dir, get_node("Animation").Extend);
	get_node("Head").set_process(true);
	get_node("Head").disabled = false;
	
	
	return;

#func _process(delta):
##	# Called every frame. Delta is time since last frame.
##	# Update game logic here.
#	printerr(get_node("Head").disabled);
#	pass
