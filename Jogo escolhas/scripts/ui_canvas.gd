extends CanvasLayer

func add_item_inventory(sprite: Texture) -> bool:
	#Funcao que recebe um sprite tipo texture e analisa se tem algum container com textura tipo null 
	#ou seja, ve se tem um container vazio. Se estiver vazio, ele adiciona o sprite recebido no container.
	for slot in $inventory/container.get_children():
		if slot.get_node("sprite").texture == null:
			slot.get_node("sprite").texture = sprite
			return true
	return false
	
func remove_item(sprite: Texture) -> void:
	#Essa funcao recebe um sprite tipo texture e analisa se ja tem algum sprite igual a esse no container.
	#Se tiver o sprite, a funcao remove o sprite do container.
	for slot in $inventory/container.get_children():
		if slot.get_node("sprite").texture == sprite:
			slot.get_node("sprite").texture = null
