extends StaticBody
class_name SymbolW
# Generic "base" class for symbols

#Constructor
func _init():
	pass
	# set a default material
	#var color = Color(0.25, 0.85,0.41)
	#var material = SpatialMaterial.new().set_albedo(color)
	#self.set_material_override(material)

# modifies the given list with this symbol advanced one iteration step
func grow():
	self.grow_children()

# recursive function, grows all child nodes, DFS order
func grow_children():
	var children = self.get_children()
	
	for child in children:
		child.grow()
