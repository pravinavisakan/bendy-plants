extends Spatial
class_name WillowLeaf

# state variables
var segments = 1;
var threshold = 10;
var link = CylinderMesh.new()
var attachment = HingeJoint.new()

var end_link = RigidBody.new()

func _init():
	#set shape of a link
	link.set_bottom_radius(00.25)
	link.set_top_radius(0.25)
	link.set_height(0.25)
	
	#set up first part of chain
	self.add_child(attachment)
	
	var meshInst = MeshInstance.new()
	meshInst.set_mesh(link)
	# TODO using an editor helper here - maybe refactor
	var colShape = CollisionShape.new()
	colShape.set_shape(RayShape.new())
	
	colShape.add_child(meshInst)
	end_link.add_child(colShape)
	
	#add link to scene tree
	self.add_child(end_link)
	
	attachment.translate(Vector3(-0.75,0,0))
	
func attach():
	pass
	#TODO avoid making attachment a global variable
	attachment.set_node_a(self.get_parent().get_path())
	attachment.set_node_b(end_link.get_path())
	attachment.set_exclude_nodes_from_collision(false)

# modifies the given list with this symbol advanced one iteration step
# here: add a link+hinge for every step, if at threshold replace with single mesh
func grow():
	pass
	
# recursive function, grows all L-System child nodes, DFS order
func grow_children():
	pass
