extends "stat.gd"

var baseValue = 0 setget setBaseValue, getBaseValue

func _ready():
	pass

func setBaseValue(value):
	baseValue = value

func getBaseValue():
	return baseValue
