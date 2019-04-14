extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	connect("area_entered", self, "DealDamage");
	pass


func DealDamage(body):
	if(body.has_method("TakeDamage")):
		body.TakeDamage(4, get_node("Katydid").position);
	pass;
	
func TakeDamage(amount, source):
	get_node("Katydid").damaged = true;
	get_node("Katydid").lifePoints -= amount;
	get_node("Katydid").animationTime = 0;
	printerr("Damage Received.");
	pass;


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
