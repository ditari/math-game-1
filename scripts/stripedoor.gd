extends Node2D

var number

# Called when the node enters the scene tree for the first time.
signal button_pressed(number)



func _on_button_pressed():
	emit_signal("button_pressed", number)

