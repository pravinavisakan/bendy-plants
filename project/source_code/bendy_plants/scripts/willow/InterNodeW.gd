extends StaticBody
class_name InterNodeW

# state variables
var age = 1
var leaves = 0
var cylinder = CylinderMesh.new()

func _init():
	# setup a cylindrical static body
	cylinder.set_bottom_radius(0.5)
	cylinder.set_top_radius(0.5)
	
	var meshInst = MeshInstance.new()
	meshInst.set_mesh(cylinder)
	
	# TODO using an editor helper here - maybe refactor
	var colShape = CollisionShape.new()
	
	colShape.add_child(meshInst)
	self.add_child(colShape)

# modifies the given list with this symbol advanced one iteration step
func grow():
	
	#debug
	#print("debug")
	
	# update own size
	age += 1;
	var current_height = cylinder.get_height()
	cylinder.set_height(2*age)

	#update transform to compensate for increased size
	var parent = self.get_parent_spatial()
	var offset = 0
	
	#TODO make more generic wrt parent type; find a way to ref own class
	if !parent || parent is StartBranch:
		offset = 0
	else:
		offset = 1
		
		
	var translation_factor = 1 + offset
	
	self.translate(Vector3(0,translation_factor,0))
	
	# add bendy branches, stochastically
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawnLeaf = rng.randf_range(0,1)
	print("leaf chance")
	print(spawnLeaf)
		
	if spawnLeaf < 1:
		print("Spawning leaf")
		var leaf = WillowLeaf.new()
		self.add_child(leaf, true)
		leaf.attach()	#set internal joint to current node
		
		#place leafy branch
		var leafOffset = rng.randf_range(0,current_height)
		var leafRot = rng.randf_range(0,2*PI)
		
		leaf.translate(Vector3(1.75,leafOffset, 0))
		leaf.rotate_x(PI/2)
		#leaf.rotate_z(leafRot)
	
	
	# perform productions on children
	self.grow_children()
	
	#debug
	#self.print_tree_pretty()
	#print(translation_factor)
	
	# recursive function, grows all child nodes, DFS order
func grow_children():
	var children = self.get_children()
	
	for child in children:
		if !(child is CollisionShape):
			child.grow()
