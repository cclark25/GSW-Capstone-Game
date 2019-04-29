extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hookAble = true;
export (Vector2) var jumpDest = Vector2(0, 25);

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_collision_layer_bit(Global.CollisionType.hookable, true);
	pass

func GetDestination(grabber):
	var p = global_position;
	if(get_angle_to(grabber.get_parent().global_position) > 0):
		p += jumpDest.rotated(get_parent().global_rotation - PI/2);
	else:
		p -= jumpDest.rotated(get_parent().global_rotation - PI/2);
	return p;

func Is_Hookable():
	return true;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
