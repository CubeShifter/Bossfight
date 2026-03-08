extends Control
@export var text:String
@export var action:String
var reading_input = false
@onready var label: RichTextLabel = $Text

@onready var button: TextureButton = $Button



func _ready() -> void:
	label.text = "[center]"+text+"[/center]"
	button.toggle_mode = true
	

	
		
# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and reading_input:
		button.button_pressed = false
		reading_input = false
		button.release_focus()
		InputMap.erase_action(action)
		InputMap.add_action(action)
		InputMap.action_add_event(action,event)
		label.text ="[center]"+ event.as_text()+"[/center]"


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reading_input = true
		label.text = "[center]Awaiting[/center]"
