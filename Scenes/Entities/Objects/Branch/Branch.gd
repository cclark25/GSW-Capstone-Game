extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func GetColorableChildren():
	return [get_node("Branch")];

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.dragable, true);
	set_collision_layer_bit(Global.CollisionType.hookable, true);
	set_collision_mask_bit(Global.CollisionType.wall, true);
	#set_collision_mask_bit(Global.CollisionType, true);
	set_contact_monitor(true);
	set_max_contacts_reported(5);
	connect("body_entered", self, "Collision");
	set_process(false);
	pass

func on_launch():
	set_process(true);

func Collision(body):
	printerr("Collide");
	if(linear_velocity.length() > 100):
		Damage.BreakObject(self);

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	#printerr(linear_velocity);
	#if(abs(linear_velocity.length()) < 1 ):
	#	Damage.BreakObject(self);
	set_process(false);
	pass
