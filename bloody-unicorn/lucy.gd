extends CanvasLayer

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
	"You made it.",
	"Here I am.",
	"Sucker.",
	"Neigh.",
	"I see you now."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_talking()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#for some reason timing works better outside the speak function
func start_talking():
	var sentinel = 0
	while(true and sentinel<1000):
		sentinel += 1
		await get_tree().create_timer(2.0).timeout
		speak(thingsLucySays)
		await get_tree().create_timer(2.0).timeout
		$LucyVoice/BlackBcgdMap.visible = false
		$LucyVoice.text = ""
		print(sentinel)

#pass an array of strings to this function
func speak(msg):
	$LucyVoice/BlackBcgdMap.visible = true
	#change position of text within the window
	var windowHalfX = (get_window().get_size_with_decorations().x)/2
	var windowHalfY = (get_window().get_size_with_decorations().y)/2
	$LucyVoice.position = Vector2(
		randi()%(windowHalfX-101)+100,
		randi()%(windowHalfY-101)+100
		)
	#output random string from array
	$LucyVoice.text = msg[randi() % msg.size()]
