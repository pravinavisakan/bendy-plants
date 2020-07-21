extends Symbol

class_name ApexW

func _init():
	var sphere = SphereMesh.new()
	sphere.set_radius(0.5)
	self.set_mesh(sphere)
	
	._init() #call super class init

# modifies the given tree with this symbol advanced one iteration step
func grow():
	# build new tree structure
	var sb = StartBranch.new()
	var base = InterNodeW.new()
	var next = InterNodeW.new()
	
	# give the base of the branch your own transform
	sb.set_transform(self.get_transform())
	
	#add branch start for later detection
	sb.add_child(base)
	
	#add child internode and translate
	base.add_child(next)
	next.translate(Vector3(0,2,0))
	
	# add apices to new tree
	var top = self.get_script().new()
	next.add_child(top)
	top.translate(Vector3(0,1,0))
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num_offshoots = rng.randi_range(1,3)
	
	if !(self.get_parent_spatial()): #hardcode first parent's offshoots
		num_offshoots = 3
	
	for i in num_offshoots:
		var offshoot = self.get_script().new()
		next.add_child(offshoot)
		
		offshoot.translate(Vector3(0,rng.randf_range(0, 2.5),0))  # move along branch
		offshoot.rotate_z(PI/4) #tilt away from branch
		offshoot.rotate_y((PI/3)*i) #tilt around branch
		offshoot.translate(Vector3(-0.875,0,0))  #move away from branch
	
	# replace self with new tree structure
	self.replace_by(sb)
	
	# delete self
	self.queue_free()
