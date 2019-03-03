extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func TakeDamage(amount, sourceLocation):
	if(!(get_child(1).damaged)):
		get_child(1).damaged = true;
		get_child(1).animationTime = 0;
		get_child(1).lifePoints -= amount;
		if(get_child(1).lifePoints <= 0):
			get_tree().change_scene("res://GameOverScreen.tscn");
		move_and_collide((position - sourceLocation ).normalized() * 75);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
