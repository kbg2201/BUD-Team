extends CanvasLayer

signal scrape_play
signal scrape_stop

var can_talk = true

#var voice = GDSAM.new()
#var audiostream = AudioStreamPlayer.new()

#crude dialogue
var thingsLucySays = [
	"Hello?",
	"Who's there?",
	"Who's there?",
	"Hey.",
	"Psst.",
	"Come here.",
	"Come here.",
	"Neigh.",
	"Can you hear me?",
	"Can you hear me?",
	"I'm a unicorn.",
	"Over here.",
	"I need help.",
	"I can hear you."
]
var thingsLucySaysWhenSheIsAboutToKillYou = [
	"Hold still.",
	"Here I am.",
	"Sucker.",
	"Neigh.",
	"I see you now.",
	"Come back here."
]

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
		await get_tree().create_timer(float((randi()%3)+1)).timeout
		speak(thingsLucySaysWhenSheIsAboutToKillYou) #changed for effect
		scrape_play.emit()
		await get_tree().create_timer(float((randi()%3)+1)).timeout
		$LucyVoice/BlackBcgdMap.visible = false
		$LucyVoice.text = ""
		print(sentinel)

#pass an array of strings to this function
func speak(msg):
	if can_talk == true:
		$LucyVoice/BlackBcgdMap.visible = true
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
		#voice.speak(audiostream,text)
