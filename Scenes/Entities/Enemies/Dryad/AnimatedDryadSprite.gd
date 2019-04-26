extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	set_process(true);
	connect("animation_finished", self, "OnAnimationFinish");
	pass

func _process(delta):
	var dir = 2 * int((get_parent().position.angle_to_point((Global.Player.position))) / (PI/3)) - 4;
	Play(dir);
	pass

func Play(dir):
	match dir:
		0, -8:
			get_parent().activeItem.position = Vector2(7, 10);
		-2:
			get_parent().activeItem.position = Vector2(0, 0);
		-4:
			get_parent().activeItem.position = Vector2(-7, 10);
		-6:
			get_parent().activeItem.position = Vector2(0, 15);
			
	play("Walk." + Global.Directions.keys()[dir]);
	
func OnAnimationFinish():
	pass