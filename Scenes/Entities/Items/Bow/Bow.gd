extends Sprite

var arrow_resource;
var dir = 0;


func _ready():
	arrow_resource = preload("../Arrow/Arrow.tscn")
	pass

func _process(delta):
	if get_parent().has_method("get_direction"):
		dir = get_parent().get_direction();
	self.rotation = dir + PI;
	pass

func Use():
	var arrow = arrow_resource.instance();
	get_parent().get_parent().add_child(arrow)
	arrow.position = get_parent().position
	arrow._shoot(dir);
	pass