# code by Codecamp BCL UI Team
# step 01
# copy the geom function
def create_box(origin, width, length, height)
  mod = Sketchup.active_model # open sketchup active_model
  ent = mod.entities # accessing the entities in mod

  # this is a basic code to make a simple box

  #define points for a rectangle in respect to origin point
  pt1 = Geom::Point3d.new(origin.x - width / 2, origin.y - length / 2, origin.z - height / 2)
  pt2 = Geom::Point3d.new(origin.x + width / 2, origin.y - length / 2, origin.z - height / 2)
  pt3 = Geom::Point3d.new(origin.x + width / 2, origin.y + length / 2, origin.z - height / 2)
  pt4 = Geom::Point3d.new(origin.x - width / 2, origin.y + length / 2, origin.z - height / 2)

  #create a group_ box group
  box_group = ent.add_group
  # create a rectanglar face
  face = box_group.entities.add_face(pt1, pt2, pt3, pt4)
  if face.normal.z < 0  # this code is used to flip the face if not upward
    face.reverse!
  end
  # pushpull the face to create the box
  face.pushpull(height)
  # end of the code
  return box_group
end


# the algorithm
# create the grid loop
# we create a 3 dimensional loop using i, j and k

for i in 0..3
  for j in 0..15
    for k in 0..3
      # put the codes here
      # the gridsize
      grid_size = 1000.mm
      # define the origin
      # we can put gradual randomise effect by corresponding the value of i, j or k to random value
      x = i * grid_size * 50.mm + rand(-0.5..0.5) * i/5.0 * grid_size
      y = j * grid_size * 50.mm + rand(-0.5..0.5) * j/5.0 * grid_size
      z = k * grid_size * j + rand(-3..3) * k/5.0 * grid_size
      origin = Geom::Point3d.new(x, y, z)
      # define the size
      width = 0.5 * grid_size
      length = 0.5 * grid_size
      height = 1.5 * grid_size
      box = create_box(origin, width, length, height)
      # for exercise, we can put transformation here as well, for example i put random rotation gradually
      angle = Math::PI * rand(-0.5..0.5) * i / 5.0
      axis = Geom::Vector3d.new(0, 0, 1)
      rotation = Geom::Transformation.rotation(origin, axis, angle)
      box.transform!(rotation)

      # here a bonus creating and applying materials
      r = j * 25# max number is 255, when minimum number is 0
      g = 120
      b = 25
      # a = 255   # max number is 100, when minimum number is 0
      color_from_rgb = Sketchup::Color.new(r, g, b)
      box.material = color_from_rgb
    end
  end
end


# parameter yg bisa dirubah
# posisi
# size
# transformation
