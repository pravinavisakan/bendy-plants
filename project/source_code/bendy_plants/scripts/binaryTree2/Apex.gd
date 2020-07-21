extends Symbol

class_name Apex

func _init():
	var sphere = SphereMesh.new()
	sphere.set_radius(0.5)
	self.set_mesh(sphere)

# modifies the given tree with this symbol advanced one iteration step
func grow():
	# build new tree structure
	var sb = StartBranch.new()
	var base = InterNode.new()
	var next = InterNode.new()
	
	# give the base of the branch your own transform
	sb.set_transform(self.get_transform())
	
	#add branch start for later detection
	sb.add_child(base)
	
	#add child internode and translate
	base.add_child(next)
	next.translate(Vector3(0,2,0))
	
	# add apices to new tree
	var top = self.get_script().new()
	var left = self.get_script().new()
	var right = self.get_script().new()
	var front_right = self.get_script().new()
	var back_left = self.get_script().new()
	
	next.add_child(top)
	next.add_child(left)
	next.add_child(right)
	next.add_child(front_right)
	next.add_child(back_left)
	
	top.translate(Vector3(0,1,0))
	
	left.translate(Vector3(-0.75,0,0))
	left.rotate_z(PI/4)
	left.rotate_x(PI/4)
	
	right.translate(Vector3(0.75,0,0))
	right.rotate_z(-PI/4)
	right.rotate_x(-PI/4)
	
	front_right.translate(Vector3(0.75,0,0))
	front_right.rotate_z(-PI/4)
	front_right.rotate_x(PI/4)
	
	back_left.translate(Vector3(-0.75,0,0))
	back_left.rotate_z(PI/4)
	back_left.rotate_x(-PI/4)
	
	# replace self with new tree structure
	self.replace_by(sb)
	
	# delete self
	self.queue_free()
