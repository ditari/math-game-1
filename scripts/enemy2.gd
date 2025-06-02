extends Node2D

var number #posisi di pintu 1 2 atau 3
var reward #0 berarti treasure, 1 segitiga, 2 kotak, 3 lingkaran 

# Called when the node enters the scene tree for the first time.
signal button_pressed(number, reward)


func _on_touch_screen_button_pressed():
	emit_signal("button_pressed", number,reward)
