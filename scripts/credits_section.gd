extends Control
class_name CreditsSection

@export_group("Internal Nodes")
@export var vbox: VBoxContainer

@export_group("Resources")
@export_file_path("*.md") var credits_file: String

func _ready() -> void:
    _populate_from_credits_file()

func _populate_from_credits_file() -> void:
    var file = FileAccess.open(credits_file, FileAccess.READ)
    var lines = file.get_as_text(true).split("\n")
    var bold_font = FontVariation.new()
    bold_font.base_font = get_theme_default_font()
    bold_font.variation_embolden = 1.2

    for line in lines:
        var label = Label.new()
        if line.begins_with("#"):
            # Header
            label.text = line.substr(1)
            label.add_theme_font_size_override("font_size", 16)
            label.add_theme_font_override("font", bold_font)
        else:
            # Regular line
            label.text = line
            label.add_theme_font_size_override("font_size", 8)
        vbox.add_child(label)
            


