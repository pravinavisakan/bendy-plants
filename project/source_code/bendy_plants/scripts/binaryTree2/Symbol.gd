extends MeshInstance
class_name Symbol
# Generic "base" class for symbols

#Constructor
func _init():
	pass

# modifies the given list with this symbol advanced one iteration step
func grow():
	self.grow_children()

# recursive function, grows all child nodes, DFS order
func grow_children():
	var children = self.get_children()
	
	for child in children:
		child.grow()
