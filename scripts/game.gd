extends Node2D

var score1 = 0
var score2 = 0

var spinner1ok = false
var spinner2ok = false

var resetting
var time = 0

signal block
signal unblock

func _ready():
	
	pass


func atualizaScore():
	get_node("Control/Player1/Score").set_text(str(score1))
	get_node("Control/Player2/Score").set_text(str(score2))

	emit_signal("block")
	spinner1ok = false
	spinner2ok = false


func _on_Spinner1_limit():
	score1 += 1
	
	get_node("Control/Player1/Message").set_text("Você ganhou!")
	get_node("Control/Player2/Message").set_text("Você perdeu!")
	
	atualizaScore()


func _on_Spinner2_limit():
	score2 += 1
	
	get_node("Control/Player2/Message").set_text("Você ganhou!")
	get_node("Control/Player1/Message").set_text("Você perdeu!")
	
	atualizaScore()


func _on_Spinner1_zero():
	spinner1ok = true
	if spinner2ok:
		reset()


func _on_Spinner2_zero():
	spinner2ok = true
	if spinner1ok:
		reset()


func reset():
	if resetting: return
	resetting = true
	
	get_node("Control/Player1/Message").set_text("")
	get_node("Control/Player2/Message").set_text("")
	
	time = 5
	get_node("EntreRound").start()
	
#	print("Reset!")

func _on_EntreRound_timeout():
	time -= 1
	if time > 1:
		get_node("Control/Player1/Score").set_text(str(time-1))
		get_node("Control/Player2/Score").set_text(str(time-1))
	if time == 1:
		get_node("Control/Player1/Score").set_text("GO!")
		get_node("Control/Player2/Score").set_text("GO!")
		resetting = false
		emit_signal("unblock")
	if time == 0:
		get_node("Control/Player1/Message").set_text("")
		get_node("Control/Player2/Message").set_text("")
