extends Symbol
class_name InterNode

# state variables
var age = 1;

func _init():
	var cylinder = CylinderMesh.new()
	cylinder.set_bottom_radius(0.5)
	cylinder.set_top_radius(0.5)
	self.set_mesh(cylinder)

# modifies the given list with this symbol advanced one iteration step
func grow():
	
	#debug
	#print("debug")
	
	# update own size
	age += 1;
	var current_height = mesh.get_height()
	mesh.set_height(2*age)

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
	
	# perform productions on children
	self.grow_children()
	
	#debug
	#self.print_tree_pretty()
	#print(translation_factor)
