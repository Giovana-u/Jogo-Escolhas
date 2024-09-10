extends ColorRect

func _ready():
	pass

func _on_Button_pressed():
	#Funcao que indica para qual cena o botao leva
	get_tree().change_scene("res://scenes/startScreen.tscn")
