extends Control

export(Resource) var bd_game
#Exporta o recurso bd_game, que é o banco de dados que contém os diálogos
onready var nome: Label = $name
onready var question: Label = $question
onready var choices: VBoxContainer = $choices
onready var walk = $walk
onready var wait = $wait
onready var ui_canvas = $".."
onready var filter = $"../../filter"
onready var invent = $"../inventory"
onready var player = $"../../player"
onready var door_1 = $"../../player/door1"
onready var door_2 = $"../../player/door2"
onready var door_3 = $"../../player/door3"
onready var door_4 = $"../../player/door4"
onready var door_5 = $"../../player/door5"
onready var door_6 = $"../../player/door6"
onready var door_7 = $"../../player/door7"
onready var lanterna = $"../../lanterna"
onready var tesoura = $"../../tesoura"
onready var comida = $"../../comida"
onready var faca = $"../../faca"
onready var gatinho = $"../../gatinho"
export var move_speed = 200


var index := 0
var inventory = []
var sum = 0
var pet = false

func _ready() -> void:
	#Funcao que chama o randomize, que permite gerar numeros aleatorios, e o load_game, que
	#e a funcao que roda as falas do jogo.
	randomize()
	load_game(index)
	
func load_game(section: int) -> void:
	#funcao que roda as falas do jogo. recebe section, que é o indice da fala que ira aparecer na tela.
	nome.text = str(bd_game.bd[section].name)
	question.text = str(bd_game.bd[section].question)
	
	for child in choices.get_children():
		child.queue_free()
	
	var options = bd_game.bd[section].options
	for option in options:
		var button = LinkButton.new()
		button.underline = LinkButton.UNDERLINE_MODE_ON_HOVER
		button.text = option.text
		button.connect("pressed", self, "_on_button_pressed", [option.next])
		choices.add_child(button)

func _on_button_pressed(next) -> void:
	#funcao que e chamada ao apertar um dos botoes nas falas. Recebe next, que e o indice da 
	#proxima fala.
	var prox
	if next == 3:
		invent.visible = true
		filter.visible = false
		load_game(next)
	 
	if next == 5:
		door_1.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
			
	elif next == 7:
		player.visible = false
		load_game(next)
		
	elif next == 8:
		player.visible = true
		door_2.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
		
	elif next == 9:
		inventory.append("lanterna")
		ui_canvas.add_item_inventory(lanterna.texture)
		player.visible = true
		door_2.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
			
	elif next == 11 or next == 16 or next == 21:
		prox = door2(next)
		player.visible = false
		load_game(prox)
	
	elif next == 18:
		player.visible = true
		door_3.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
	
	elif next == 19:
		inventory.append("comida")
		ui_canvas.add_item_inventory(comida.texture)
		load_game(next)
		
	elif next == 22:
		inventory.append("tesoura")
		ui_canvas.add_item_inventory(tesoura.texture)
		load_game(next)
		
	elif next == 25:
		player.visible = false
		load_game(next)
		
	elif next == 26:
		player.visible = true
		door_4.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
		
	elif next == 28:
		prox = door3(next)
		load_game(prox)
	
	elif next == 29:
		player.visible = true
		door_4.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
		
	elif next == 31:
		player.visible = true
		door_5.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
		
	elif next == 32:
		player.visible = false
		load_game(next)
		
	elif next == 33:
		prox = door4(next)
		load_game(prox)
		
	elif next == 41:
		inventory.erase("tesoura")
		player.visible = true
		door_5.moving = true
		choices.visible = false
		walk.start()
		ui_canvas.remove_item(tesoura.texture)
		load_game(next)
		
	elif next == 44:
		player.visible = false
		load_game(next)
		
	elif next == 47:
		prox = door5(next)
		load_game(prox)
		
	elif next == 48:
		inventory.append("faca")
		ui_canvas.add_item_inventory(faca.texture)
		load_game(next)
		
	elif next == 50 or next == 52:
		player.visible = true
		door_6.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
	
	elif next == 55:
		player.visible = false
		load_game(next)
	
	elif next == 56:
		prox = door6(next)
		load_game(prox)
	
	elif next == 57:
		inventory.erase("comida")
		ui_canvas.remove_item(comida.texture)
		ui_canvas.add_item_inventory(gatinho.texture)
		pet = true
		print(pet)
		load_game(next)
	
	elif next == 60:
		player.visible = true
		door_7.moving = true
		choices.visible = false
		walk.start()
		load_game(next)
	
	elif next == 63:
		player.visible = false
		load_game(next)
		
	elif next == 64:
		prox = door7(next)
		load_game(prox)
	
	elif next == -1:
		get_tree().change_scene("res://scenes/final1.tscn")
	elif next == -2:
		get_tree().change_scene("res://scenes/final2.tscn")
	elif next == -3:
		get_tree().change_scene("res://scenes/final3.tscn")
	elif next == -4:
		get_tree().change_scene("res://scenes/final4.tscn")
	elif next == -5:
		get_tree().change_scene("res://scenes/final5.tscn")
	elif next == -6:
		get_tree().change_scene("res://scenes/final6.tscn")
	else:
		load_game(next)
		
func door2(next) -> int:
	#Funcao que faz o calculo para saber se a personagem achou o objeto ou nao. Recebe next que e
	#o indice da proxima fala. 
	var random_float = randf()
	if "lanterna" in inventory:
		if random_float < 0.2 and not "tesoura" in inventory:
			choices.visible = false
			wait.start()
			next = 21
		elif random_float < 0.1 and "tesoura" in inventory and not "comida" in inventory:
			choices.visible = false
			wait.start()
			next = 16
		else:
			next = 17
	else:
		next = 14
	return next

func door3(next) -> int:
	#Funcao que faz a soma para saber se o jogador apertou determinadas vezes a fala. Recebe next que e
	#o indice da proxima fala.
	if sum < 80:
		next = 28
		sum += 1
		print(sum)
	else:
		player.visible = true
		door_4.moving = true
		choices.visible = false
		walk.start()
		next = 29
	return next

func door4(next) -> int:
	#Funcao que analisa se o item tesoura esta no inventario. Recebe next que e o indice da proxima fala. 
	if "tesoura" in inventory:
		next = 36
	else:
		next = 33
	return next

func door5(next) -> int:
	#Funcao que faz o calculo para saber se a personagem achou o objeto ou nao. Recebe next que e
	#o indice da proxima fala. 
	var random_float = randf()
	if random_float < 0.05 and not "faca" in inventory:
		choices.visible = false
		wait.start()
		next = 47
	else:
		next = 49
		sum += 1
		print(sum)
	return next

func door6(next) -> int:
	#Funcao que analisa para saber se o item comida esta no inventario. Recebe next que e o indice da proxima fala. 
	if "comida" in inventory:
		next = 56
	else:
		next = 58
	return next
	
func door7(next) -> int:
	#Funcao que indica qual o final que o jogador fez, dependendo de quais objetos ele possui
	#no inventario ao chegar na última porta. Recebe next que e o indice da proxima fala. 
	if (not "tesoura" in inventory and not "faca" in inventory) and pet == false:
		next = 64
	elif (not "tesoura" in inventory and not "faca" in inventory) and pet == true:
		next = 67
	elif ("tesoura" in inventory or "faca" in inventory) and pet == false:
		next = 76
	elif ("tesoura" in inventory or "faca" in inventory) and pet == true:
		next = 81
	return next
	
func _on_walk_timeout():
	#funcao chamada quando o timer walk termina, fazendo as opcoes resposta ficarem visiveis
	choices.visible = true

func _on_wait_timeout():
	#Funcao chamada quando o timer wait termina, fazendo as opcoes resposta ficarem visiveis
	choices.visible = true
	
func _on_exit_pressed():
	#Funcao que encaminha o jogador para a tela inicial ao apertar a palavra sair.
	get_tree().change_scene("res://scenes/startScreen.tscn")



