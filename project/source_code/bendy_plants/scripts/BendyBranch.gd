extends Spatial
class_name BendyBranch

# state variables
var segments = 1;
var threshold = 10;
var link = CylinderMesh.new()
var attachment = PinJoint.new()

# recursive function, grows all child nodes, DFS order
func grow_children():
	var children = self.get_children()
	
	for child in children:
		child.grow()

func _init():
	#set shape of a link
	link.set_bottom_radius(0)
	link.set_top_radius(0.25)
	link.set_height(0.25)
	
	#set up first part of chain
	self.add_child(attachment)
	
	var first_link = RigidBody.new()
	var meshInst = MeshInstance.new()
	meshInst.set_mesh(link)
	# TODO using an editor helper here - maybe refactor
	var colShape = CollisionShape.new()
	
	colShape.add_child(meshInst)
	first_link.add_child(colShape)
	
	#add link to scene tree
	self.add_child(first_link)
	
	attachment.set_node_b(first_link.get_path())
	
func attach():
	#TODO avoid making attachment a global variable
	attachment.set_node_a(self.get_parent())

# modifies the given list with this symbol advanced one iteration step
# here: add a link+hinge for every step, if at threshold replace with single mesh
#func grow():
	
