extends CanvasLayer

signal scrape_play
signal scrape_stop

var can_talk = true

#var voice = GDSAM.new()
#var audiostream = AudioStreamPlayer.new()

#crude dialogue
var thingsSucySays = [
	"Don't listen to the other voice you idiot!",
	"Hey! Hey! Hey! Hello? Hey! Hey!",
	"I need more help than they do!!!",
	"You are being so problematic right now. I can't believe this.",
	"Follow my voice!!! What are you doing aaaa",
	"I'm actually am a unicorn, unlike that freak trying to kill you.",
	"Come over here. Not over there. Over here. Now.",
	"Stop ignoring me!! Hurry up!!!",
	"You can hear me right? Follow my voice then you moron!",
	"What are they saying? It's all lies don't listen!",
	"I'm trying to help you!! Just trust me!"
]
var thingsSucySaysWhenYouAreAboutToDie = [
	"This isn't my fault by the way.",
	"Oh you're in trouble now huh? Wow who could've seen this coming.",
	"You're so screwed. I'm so screwed. This sucks.",
	"YOU WERE SUPPOSED TO COME OVER HERE UGHHH"
]

var target_dialogue = thingsSucySays
var talk_speed : int = 5 #make sure this stays an int 

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
		#$SucyVoice/BlackBcgdMap.visible = false
		$SucyVoice.text = ""
		print(sentinel)

#pass an array of strings to this function
#return length of line of dialogue
func speak(msg) -> int:
	if can_talk == true:
		#$SucyVoice/BlackBcgdMap.visible = true
		#change position of text within the window
		var windowHalfX = (get_window().get_size_with_decorations().x)/2
		var windowHalfY = (get_window().get_size_with_decorations().y)/2
		$SucyVoice.position = Vector2(
			randi()%(windowHalfX-101)+100,
			randi()%(windowHalfY-101)+100
			)
		#output random string from array
		var text = msg[randi() % msg.size()]
		$SucyVoice.text = text
		#actual text length in seconds is too long, quarter it
		return text.length() / 4
	else:
		return 0

#should change Sucy's dialogue when she begins to move
func _on_enemy_unicorn_lucy_kill() -> void:
	target_dialogue = thingsSucySaysWhenYouAreAboutToDie
	talk_speed = 2
