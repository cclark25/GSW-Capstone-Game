extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("Walls").set_collision_layer_bit(Global.CollisionType.wall, true);
	get_node("Walls").set_collision_mask_bit(Global.CollisionType.player, true);
	get_node("Walls").set_collision_mask_bit(Global.CollisionType.enemy, true);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
