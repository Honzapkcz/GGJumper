extends Resource
## Metadata Resource for Script integration in Game editor[br][br]
## Don't forget to import this file alongside actual object scene
## when trying to integrate it with script dock.
class_name EditorScriptObject

## Constant StringName pointing to object ClassName
@export var object: StringName
## Names of properties to be recognised as input by script dock
@export var inputs: PackedStringArray
## Names of properties to be recognised as output by script dock
@export var outputs: PackedStringArray
