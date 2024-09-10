extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_returnBtn_pressed():
	#Funcao para voltar a tela inicial ao aprtar em voltar.
	queue_free()
