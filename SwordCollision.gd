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
	if(get_parent().visible): body.TakeDamage(8, get_parent().position);
	pass;
	
func TakeDamage(amount, sourceLocation):
	pass



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
