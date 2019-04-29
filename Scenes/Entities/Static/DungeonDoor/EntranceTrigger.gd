extends CollisionShape2D

func _ready():
	connect("body_entered", self, "body_entered");
	
func body_entered(body):
	if body.has_method("GetKeys") && body.GetKeys() > 0:
		printerr("Unlocked");
		body.SetKeys(body.GetKeys() - 1);
		queue_free()