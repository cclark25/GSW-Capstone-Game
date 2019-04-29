extends Area2D

func _ready():
	connect("body_entered", self, "body_entered");
	set_collision_layer_bit(Global.CollisionType.trigger, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	pass

func body_entered(body):
	printerr("Here");
	if body == Global.Player && body.get("keys") > 0:
		body.keys -= 1
		printerr ("Key Used");
		get_node("EntranceTrigger").disabled = true;
		get_parent().unlock();
		