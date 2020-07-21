extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var count = 0
var total = 0
var limit = 5
var seconds_per_growth_step = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	#generate tree
	var tree_gen = TreeGenerator.new()
	var tree = tree_gen.spawn_tree(0,"willow", 0)
	
	# add generated tree to current scene
	self.add_child(tree, true)
	
func _process(delta):
	
	# can't run grow on Apex before add_child because it will refuse
	# to replace itself in the scene tree without first being put in the scene, 
	# so it just deletes itself. Iterating over grow calls here for time being
	# TODO fix this, but leave possibility of continuous time-based growth
	
	var rootNode = self.get_child(2)
	
	# advance plant
	count += delta
	
	if count > seconds_per_growth_step:
		count = 0
		total +=1
		if total < limit:
			rootNode.grow()
	
