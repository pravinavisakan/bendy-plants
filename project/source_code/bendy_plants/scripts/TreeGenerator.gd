extends Reference
class_name TreeGenerator

# load plant component/mesh types here
# ideas: cylinder (testing), woody_branch/bendy_branch (state-based switch), leaf? - can get species specific
# update - or just have them as classes

#Constructor
func _init():
	pass
	
#Main function - iterate over grammar, add meshes to current scene
func spawn_tree(origin, type, iterations):
	
	# TODO add origin selection
	
	var rootNode;
	
	if(type == "willow"):
		rootNode = ApexW.new();
	else:
		rootNode = Apex.new();
	
	# advance plant for requested number of iterations
	# TODO fix in case of pre-scene addition
	#for i in range(iterations):
	#	print(i)
	#	rootNode.grow()
	
	return rootNode
