extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_collision_layer_bit(Global.CollisionType.wall, true);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
