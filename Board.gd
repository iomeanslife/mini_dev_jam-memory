extends Node2D

enum State {
	HIDDEN,
	PEEKED,
	REVEALED
}

onready var cards = $Cards
onready var winPanel = $WinPanel
onready var winTimeCount = $WinPanel/StatsControl/TimeCountLabel
onready var winMissesCountLabel = $WinPanel/StatsControl/MissesCountLabel
onready var statsControl = $StatsControl
onready var timeCountLabel = $StatsControl/TimeCountLabel
onready var missesCountLabel = $StatsControl/MissesCountLabel


var timeAccurate = 0.0
var time = -1
var misses = 0
var children
var peekedCard
var animals = ["elephant", "giraffe", "hippo","monkey","panda",
"parrot","penguin","pig","rabbit","snake"]

func _ready():
	randomize()
	animals.shuffle()
	
	children = cards.get_children()
	children.shuffle()
	
	for n in children.size()-1:
		if n%2==1:
			continue

		children[n].set_sprite(animals[n])
		children[n+1].set_sprite(animals[n])

		children[n].connect("activated",self,"_on_Card_activated",[children[n]])
		children[n+1].connect("activated",self,"_on_Card_activated",[children[n+1]])

func _process(delta):
	timeAccurate += delta
	if timeAccurate > time:
		time += 1
		timeCountLabel.text = String(time)

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

			for child in children:
				if child.state == State.HIDDEN:
					return
			
			winPanel.visible = true
			winMissesCountLabel.text = String(misses)
			winTimeCount.text  = String(time)
			statsControl.visible = false
			
		else:
			print("fail...")
			peekedCard.hide_me()
			card.hide_me()

			peekedCard = null
			card = null
			misses += 1
			missesCountLabel.text = String(misses)


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Board.tscn")
