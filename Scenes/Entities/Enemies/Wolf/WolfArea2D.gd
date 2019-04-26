extends Area2D

func _ready():
	set_collision_mask_bit(Global.CollisionType.player, true);
	
	connect("body_entered", self, "DealDamage");
	connect("area_entered", self, "DealDamage");
	pass

func DealDamage(body):
	Damage.DealDamage(10, body, Damage.DamageType.bite, self);
	pass;
	


