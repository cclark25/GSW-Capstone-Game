extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dir = 0;
var invert = false;
export (float) var radPerSec = 5*PI;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("area_entered", self, "DealDamage");
	set_process(false);
	get_node("CollisionShape2D").disabled = true;
	set_collision_layer_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	pass

func DealDamage(body):
	body.TakeDamage(8, get_parent().position);
	pass;

func Use():
	if(!is_processing() && get_parent().has_method("get_direction")):
		dir = get_parent().get_direction() * PI/4;
		
		if(dir > PI/2 || dir < -PI/2):
			invert = true;
		else:
			invert = false;
		
		if(invert):
			dir += PI/2 - PI/6;
		else:
			dir -= PI/2 - PI/6;
			
		set_process(true);
		rotation = dir;
		visible = true;
		get_node("CollisionShape2D").disabled = false;
	pass;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if(invert):
		rotation -= delta*radPerSec;
		if(rotation <= dir - 2*PI/3):
			set_process(false);
			visible = false;
	else:
		rotation += delta*radPerSec;
		if(rotation >= dir + 2*PI/3):
			set_process(false);
			visible = false;
	#set_process(false);
	return;
