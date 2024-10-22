extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("body_entered", self, "DealDamage");
	connect("area_entered", self, "DealDamage");
	pass

func DealDamage(body):
	printerr("damages")
	Damage.DealDamage(10, body, Damage.DamageType.bite, self);
	pass;
	
func TakeDamage(amount, source):
	get_parent().damaged = true;
	get_parent().lifePoints -= amount;
	get_parent().animationTime = 0;
	pass;


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
