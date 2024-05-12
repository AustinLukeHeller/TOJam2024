extends Node3D
@export var enemyPrefab: Resource
@export var spawnsParent: Node
@export var spawnRate: float
var spawnTimer: float = 0.0
var activated: bool = true
var random: RandomNumberGenerator
# Called when the node enters the scene tree for the first time.
func _ready():
	random = RandomNumberGenerator.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(activated):
		spawnTimer+=delta
		if(spawnTimer>=spawnRate):
			print("spawns")
			spawnTimer=0
			var spawnPoint = spawnsParent.get_children()[random.randi_range(0,spawnsParent.get_child_count()-1)]
			spawnPoint.add_child(load(enemyPrefab.resource_path).instantiate())
	pass
