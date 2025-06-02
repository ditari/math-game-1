extends Node2D

var number

# Called when the node enters the scene tree for the first time.
signal button_pressed(sender, number)


func _on_touch_screen_button_pressed():
	emit_signal("button_pressed", self, number)
