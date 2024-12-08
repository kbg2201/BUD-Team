extends CanvasLayer

signal scrape_play
signal scrape_stop

var can_talk = true

#var voice = GDSAM.new()
#var audiostream = AudioStreamPlayer.new()

#crude dialogue
var thingsLucySays = [
	"Hello?",
	"Come here.",
	"Please don't ignore me :( ",
	"Neigh.",
	"Can you hear me?",
	"If you can hear me, follow my voice.",
	"If you can hear me, follow my voice.",
	"If you can hear me, follow my voice. Please.",
	"I'm a unicorn :( ",
	"*sobbing*",
	"*sobbing*",
	"I need help :( ",
	"I need help :( ",
	"Who's there? "
]
var thingsLucySaysWhenSheIsAboutToKillYou = [
	"Hold still.",
	"Here I am.",
	"Sucker.",
	"Neigh.",
	"I see you now.",
	"Come back here.",
	"NGHEUGHAHHHHHHAAAAAHHH"
]

var target_dialogue = thingsLucySays
var talk_speed : int = 6 #make sure this stays an int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start_talking()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#for some reason timing works better outside the speak function
func start_talking():
	var sentinel = 0
	while(true and sentinel<1000):
		scrape_stop.emit()
		sentinel += 1
		await get_tree().create_timer(float((randi()%talk_speed)+1)).timeout
		var linelen = speak(target_dialogue)
		scrape_play.emit()
		#hide dialogue time based on length of line of dialogue
		await get_tree().create_timer(float(linelen)).timeout
		#$LucyVoice/BlackBcgdMap.visible = false
		$LucyVoice.text = ""
		print(sentinel)

#pass an array of strings to this function
#return length of line of dialogue
func speak(msg) -> int:
	if can_talk == true:
		#$LucyVoice/BlackBcgdMap.visible = true
		#change position of text within the window
		var windowHalfX = (get_window().get_size_with_decorations().x)/2
		var windowHalfY = (get_window().get_size_with_decorations().y)/2
		$LucyVoice.position = Vector2(
			randi()%(windowHalfX-101)+100,
			randi()%(windowHalfY-101)+100
			)
		#output random string from array
		var text = msg[randi() % msg.size()]
		$LucyVoice.text = text
		#actual text length in seconds is too long, quarter it
		return text.length() / 4
	else:
		return 0
#should change Lucy's dialogue when she begins to move
func _on_enemy_unicorn_lucy_kill() -> void:
	target_dialogue = thingsLucySaysWhenSheIsAboutToKillYou
	talk_speed = 2
