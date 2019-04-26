extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	connect("body_entered", self, "Hit");
	connect("area_entered", self, "Hit");
	pass

func Hit(body):
	var intensity = get_parent().linear_velocity.length();
	if(intensity > 100):
		#intensity = min(intensity, 333);
		Damage.DealDamage(round(intensity*10 / 1000), body, Damage.DamageType.bludgeon, self);
		get_parent().Collision(body);
	return;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
