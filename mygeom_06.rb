mod = Sketchup.active_model # open sketchup active_model
ent = mod.entities # accessing the entities in mod
sel = mod.selection

#random 1
#yaallah mo jadi 8ball susah amat ya trnyt

i = 0
while i < 5
  puts i
  random = rand(1..10)
  puts random
  a = 25.mm
  width = 5 * a
  length = 5 * a
  height = 2 * a * random

  origin = Geom::Point3d.new(width * 10 * rand(0..10).mm, length * 10 * rand(0..10).mm ,0)

  pt1 = Geom::Point3d.new(origin.x - width/2, origin.y - length/2, origin.z - height/2)
  pt2 = Geom::Point3d.new(origin.x + width/2, origin.y - length/2, origin.z - height/2)
  pt3 = Geom::Point3d.new(origin.x + width/2, origin.y + length/2, origin.z - height/2)
  pt4 = Geom::Point3d.new(origin.x - width/2, origin.y + length/2, origin.z - height/2)

  group = ent.add_group
  group_ent= group.entities
  face = group_ent.add_face(pt1, pt2, pt3, pt4)

  if face.normal.z < 0
    face.reverse!
  end

  face.pushpull(height)
  i = i + 1
end
