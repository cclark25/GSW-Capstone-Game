extends Node2D

var _scale = Vector2(1,1)
var total = 30;

func SetHealthBar(amount,Hitpoints):
	_scale.x = (Hitpoints - amount)/total;
	$Bar.set_scale(_scale)
	pass