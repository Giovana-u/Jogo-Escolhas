extends Position2D

export var speed = 200
export var moving = false
export var sinal = false

onready var astrid = $"../astrid"
onready var door = self.global_position

func go_there(delta):
	#Funcao que analisa a posicao global da personagem e do Position2D para indicar para onde a personagem deve ir.
	
	if moving:
		#Se moving for igual a true, a animacao da personagem e ativada e ela anda ate o Position2D
		astrid.playing = true
		astrid.global_position = astrid.global_position.move_toward(door, delta*speed)
		
	if astrid.global_position == door:
		#Se a posicao da personagem for igual a posicao do Position2D, a animacao e parada e ela para de andar
		moving = false
		astrid.playing = false
		
func _process(delta):
	#funcao que e chamada a cada frame, ela chama a funcao go_there
	go_there(delta)
	

