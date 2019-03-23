extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dir = 0;
export (float) var radPerSec = 5*PI;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("area_entered", self, "DealDamage");
	set_process(false);
	get_node("CollisionShape2D").disabled = true;
	pass

func DealDamage(body):
	body.TakeDamage(8, get_parent().position);
	pass;

func Use():
	if(!is_processing() && get_parent().has_method("get_direction")):
		dir = get_parent().get_direction().angle();
		if(sin(dir) < 0):
			dir *= -1;
		set_process(true);
		rotation = dir;
		visible = true;
		get_node("CollisionShape2D").disabled = false;
	pass;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var speed = (dir + PI/2 - rotation) / (PI/2);
	
	rotate(delta * radPerSec * speed);
	if(rotation >= dir + PI/2 - .001):
		set_process(false);
		get_node("CollisionShape2D").disabled = true;
		visible = false;
	pass
