extends Node2D

var _scale = Vector2(1,1)

func SetHealthBar(curHP, maxHP):
	get_node("Bar").scale.x = max((maxHP/10)/3, 0);
	get_node("Bar").get_node("HP_Bar").scale.x = curHP*1.0 / maxHP;	
	pass