extends Node2D

enum State {
	HIDDEN,
	PEEKED,
	REVEALED
}

onready var cards = $Cards
var peekedCard

var animals = ["elephant", "giraffe", "hippo","monkey","panda",
"parrot","penguin","pig","rabbit","snake"]

func _ready():
	randomize()
	animals.shuffle()
	
	var children = cards.get_children()
	children.shuffle()
	
	for n in children.size()-1:
		if n%2==1:
			continue

		children[n].set_sprite(animals[n])
		children[n+1].set_sprite(animals[n])

		children[n].connect("activated",self,"_on_Card_activated",[children[n]])
		children[n+1].connect("activated",self,"_on_Card_activated",[children[n+1]])

func _on_Card_activated(card):
	card.state = State.PEEKED
	print(card.key)
	if peekedCard == null:
		peekedCard = card
	else:
		if peekedCard.key == card.key:
			print("MATCH!")
			card.state = State.REVEALED
			peekedCard.state = State.REVEALED
			peekedCard = null
			card = null
		else:
			print("fail...")
			peekedCard.hide_me()
			card.hide_me()
						
			peekedCard = null
			card = null
