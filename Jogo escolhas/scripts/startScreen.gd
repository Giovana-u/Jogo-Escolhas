extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_startBtn_pressed():
	#Quando o botão iniciar for pressionado, a cena startScreen é alterada para a cena Main.
	get_tree().change_scene("res://scenes/Main.tscn")
	
func _on_crditosBtn_pressed():
	var creditsScreen = load("res://scenes/creditsScreen.tscn").instance()
	#instancia a cena creditos
	get_tree().current_scene.add_child(creditsScreen)
	#Abre a cena créditos em cima da cena startScreen
	
func _on_quitBtn_pressed():
	#Quando o botão sair for pressionado, o jogo é fechado.
	get_tree().quit()
