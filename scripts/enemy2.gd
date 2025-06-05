extends Node2D

var number #posisi di pintu 1 2 atau 3
var type 

# Called when the node enters the scene tree for the first time.
signal button_pressed(number, type)



func _on_button_pressed():
	emit_signal("button_pressed", number,type)
