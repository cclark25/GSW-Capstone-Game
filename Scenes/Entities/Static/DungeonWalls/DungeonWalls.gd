extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (bool) var NorthDoor = true;
export (bool) var SouthDoor = true;
export (bool) var EastDoor = true;
export (bool) var WestDoor = true;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var n = Global.GetDoor("North", self);
	var s = Global.GetDoor("South", self);
	var w = Global.GetDoor("West", self);
	var e = Global.GetDoor("East", self);
	w.visible = WestDoor;
	e.visible = EastDoor;
	n.visible = NorthDoor;
	s.visible = SouthDoor;
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
