extends Node2D

enum State {
	HIDDEN,
	PEEKED,
	REVEALED
}

onready var spriteRevealed = $SpriteRevealed
onready var spritePeek = $SpritePeek
onready var spriteHidden = $SpriteHidden
onready var timer = $Timer
onready var jiggleAnimation = $JiggleAnimation
onready var popStarEffectAnimation = $PopStarEffect/PopStarAnimation

export var key = "elephant"
export(State) var state setget set_state

signal activated

func set_state(value):
	state = value
	match (state):
		State.HIDDEN:
			spritePeek.visible = false
			spriteHidden.visible = true
		State.PEEKED:
			spritePeek.visible = true
			spriteHidden.visible = false
			pass
		State.REVEALED:
			spriteHidden.visible = false
			spritePeek.visible = false
			spriteRevealed.visible = true
			jiggleAnimation.play("RevealedJiggle")
			popStarEffectAnimation.play("StarPopping")
			pass

func hide_me():
	timer.start(1.0)

func set_sprite(key):
	self.key = key
	spritePeek.texture = load("res://Art/Square without details (outline)/"+key+".png")
	spriteRevealed.texture = load("res://Art/Square (outline)/"+key+".png")

func _on_Card_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		if state == State.HIDDEN:
			emit_signal("activated")


func _on_Timer_timeout():
	# print("hidding.......")
	set_deferred("state",State.HIDDEN)
