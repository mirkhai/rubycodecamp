# rubycodecamp
Ruby CodeCamp Practices by Mirta Khairunnisa

# Growing Iteration Code by Salman Mirta Nisrina Muthiah
srand(1)

def create_box(origin, width, length, height)
  mod = Sketchup.active_model # open sketchup active_model
  ent = mod.entities # accessing the entities in mod

  # simple box code
  # define points for a rectangle in respect to origin point
  pt1 = Geom::Point3d.new(origin.x - width / 2, origin.y - length / 2, origin.z - height / 2)
  pt2 = Geom::Point3d.new(origin.x + width / 2, origin.y - length / 2, origin.z - height / 2)
  pt3 = Geom::Point3d.new(origin.x + width / 2, origin.y + length / 2, origin.z - height / 2)
  pt4 = Geom::Point3d.new(origin.x - width / 2, origin.y + length / 2, origin.z - height / 2)

  # create a group_ box group
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

def box_minus_x(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x - (width/2.0 + new_width/2.0)
  y = origin.y + rand(-1.0..1.0) * 30.mm
  z = origin.z + rand(-1.0..1.0) * 30.mm
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def box_positive_x(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x + (width/2.0 + new_width/2.0)
  y = origin.y #+ rand(-1.0..1.0) * 30.mm
  z = origin.z #+ rand(-1.0..1.0) * 30.mm
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def box_minus_y(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x
  y = origin.y - (length/2.0 + new_length/2.0)
  z = origin.z
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def box_positive_y(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x
  y = origin.y + (length/2.0 + new_length/2.0)
  z = origin.z
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def box_minus_z(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x
  y = origin.y
  z = origin.z - (height/2.0 + new_height/2.0)
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def box_positive_z(side, iteration, origin, width, length, height)
  new_width = width * rand(0.8..1.2)
  new_length = new_width
  new_height = new_width
  x = origin.x
  y = origin.y
  z = origin.z + (height/2.0 + new_height/2.0)
  new_origin = Geom::Point3d.new(x, y ,z)
  recursive_box(side, iteration, new_origin, new_width, new_length, new_height)
end

def select_side(side, iteration, origin, width, length, height)
  case side
  when 1
    box_minus_x(side, iteration, origin, width, length, height)
  when 2
    box_minus_y(side, iteration, origin, width, length, height)
  when 3
    box_minus_z(side, iteration, origin, width, length, height)
  when 4
    box_positive_x(side, iteration, origin, width, length, height)
  when 5
    box_positive_y(side, iteration, origin, width, length, height)
  when 6
    box_positive_z(side, iteration, origin, width, length, height)
  else
    puts("no options")
  end
end

def recursive_box(side, iteration, origin, width, length, height)
  iteration = iteration - 1
  # create a box with the given parameter
  box = create_box(origin, width, length, height)
  if iteration > 0
    # create another box
    if iteration % 5 == 0 #branching on every 5th iteration
      # branch 1
      new_side1 = rand(1..6) # choose the direction from 1 to 3
      # check if it goes to rhe opposite direction , change direction
      if new_side1 - 3 == side || new_side1 + 3 == side
        new_side1 = (new_side1 + 1) % 6
      end
      select_side(new_side1, iteration, origin, width, length, height)
      # branch 2
      new_side2 = rand(4..6) # choose the direction from 4 to 6
      # check if it goes to the opposite direction, change the direction
      if new_side2 - 3 == side ||new_side2 + 3 == side
        new_side2 = (new_side2 + 1) % 6
      end
      if new_side2 == new_side1
        new_side2 = (new_side2 + 1) % 6
      end
      select_side(new_side2, iteration, origin, width, length, height)
    else
      # if not in 5th iteration, continue to the
      select_side(side, iteration, origin, width, length, height)
    end
  end
end

origin = Geom::Point3d.new(0, 0, 0)
recursive_box(1, 31, origin, 100.mm, 100.mm, 100.mm)
