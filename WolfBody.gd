extends KinematicBody2D

var lifePoints = 15;
export (bool) var isAttacking = false;
export (bool) var damaged = false;

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	
	
	pass

func _process(delta):
	var vectorToPlayer = Vector2(position.x - Global.Player.position.x, position.y - Global.Player.position.y);
	
	translate(-delta * vectorToPlayer)
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	


func Damage(amount, sourceLocation):
	if(!damaged):
		damaged = true;
		lifePoints -= amount;
		if(lifePoints <= 0):
			self_modulate.b = 4;
		position += (position - sourceLocation ).normalized() * 75;
	pass
	
	return;