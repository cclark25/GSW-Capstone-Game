extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("area_entered", self, "DealDamage");
	pass

func DealDamage(body):
	body.get_parent().Damage(4, get_parent().position);
	pass;


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
