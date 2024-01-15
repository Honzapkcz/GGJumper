## Thanks to Godot Docs for fabulous documentation
## Everything copied from there
@icon("res://icon.png")
extends Object

enum Direction {LEFT, RIGHT, UP, DOWN}

# Built-in types.
@export var string = ""
@export var int_number = 5
@export var float_number: float = 5

# Enums.
@export var type: Variant.Type
@export var format: Image.Format
@export var direction: Direction

# Resources.
@export var image: Image
@export var custom_resource: Resource

# Typed arrays.
@export var int_array: Array[int]
@export var direction_array: Array[Direction]
@export var image_array: Array[Image]
@export var packed_array: PackedStringArray

@export_category("Statistics")
@export var hp = 30
@export var speed = 1.25

@export_color_no_alpha var dye_color: Color

@export_dir var sprite_folder_path: String

@export_enum("Warrior", "Magician", "Thief") var character_class: int
@export_enum("Slow:30", "Average:60", "Very Fast:200") var character_speed: int
@export_enum("Rebecca", "Mary", "Leah") var character_name: String = "Rebecca"

@export_exp_easing var transition_speed
@export_exp_easing("attenuation") var fading_attenuation
@export_exp_easing("positive_only") var effect_power

@export_file var sound_effect_path: String
@export_file("*.txt") var notes_path: String

@export_flags("Fire", "Water", "Earth", "Wind") var flag_elements = 0
@export_flags("Self:4", "Allies:8", "Foes:16") var flag_targets = 0
@export_flags("Self:4", "Allies:8", "Self and Allies:12", "Foes:16") var merge_targets = 0
@export_flags("A:16", "B", "C") var x

@export_flags_2d_navigation var navigation_layers: int
@export_flags_2d_physics var physics_layers: int
@export_flags_2d_render var render_layers: int
@export_flags_3d_navigation var navigation_layers_3d: int
@export_flags_3d_physics var physics_layers_3d: int
@export_flags_3d_render var render_layers_3d: int
@export_flags_avoidance var avoidance_layers: int

@export_global_dir var global_dir: String

@export_global_file var global_file_path: String
@export_global_file("*.txt") var global_filter_path: String

@export_group("Racer Properties")
@export var nickname = "Nick"
@export var age = 26

@export_group("Car Properties", "car_")
@export var car_label = "Speedy"
@export var car_number = 3

@export_group("", "")
@export var ungrouped_number = 3

@export_multiline var character_biography

@export_node_path("Button", "TouchScreenButton") var some_button

@export_placeholder("Name in lowercase") var character_id: String

@export_range(0, 20) var number
@export_range(-10, 20) var number2
@export_range(-10, 20, 0.2) var number3: float

@export_range(0, 100, 1, "or_greater") var power_percent
@export_range(0, 100, 1, "or_greater", "or_less") var health_delta

@export_range(-180, 180, 0.001, "radians_as_degrees") var angle_radians
@export_range(0, 360, 1, "degrees") var angle_degrees
@export_range(-8, 8, 2, "suffix:px") var target_offset

@export_group("Racer Properties")
@export var nickname2 = "Nick"
@export var age2 = 26

@export_subgroup("Car Properties", "car_")
@export var car_label2 = "Speedy"
@export var car_number2 = 3
