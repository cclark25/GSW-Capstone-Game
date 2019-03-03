extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func TakeDamage(amount, sourceLocation):
	if(!(get_parent().damaged)):
		get_parent().damaged = true;
		get_parent().animationTime = 0;
		get_parent().lifePoints -= amount;
		if(get_parent().lifePoints <= 0):
			get_parent().self_modulate.b = 4;
		get_parent().position += (get_parent().position - sourceLocation ).normalized() * 75;
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
