extends CanvasLayer

#crude dialogue
var thingsLucySays = [
	"Hello?",
	"Hello?",
	"Hey.",
	"Psst.",
	"Come here.",
	"Come here.",
	"Neigh.",
	"Can you hear me?",
	"Can you hear me?",
	"I'm a unicorn.",
	"Over here.",
	"I need help."
]
var thingsLucySaysWhenSheIsAboutToKillYou = [
	"Hold still.",
	"You made it.",
	"Here I am.",
	"Sucker.",
	"Neigh."
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
		await get_tree().create_timer(0.75).timeout
		speak(thingsLucySays)
		await get_tree().create_timer(2.0).timeout
		$LucyVoice.text = ""
		print(sentinel)

#pass an array of strings to this function
func speak(msg):
	#change position of text
	$LucyVoice.position = Vector2(randi()%219+50,randi()%189+50)
	#output random string from array
	$LucyVoice.text = msg[randi() % msg.size()]
