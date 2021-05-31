# code by Codecamp BCL UI Team
mod = Sketchup.active_model # Open model
ent = mod.entities # All entities in model
sel = mod.selection # Current selection


for i in -5..1 # the number of layers
  #puts i
  # create a matrix of points in 2 dimensional matrix
  matrix = Array.new
  for j in -2..5 #bisa diubah
    points = Array.new
    for k in -3..3
      x = j * 10.mm * 100.mm
      y = k  * 100.mm
      # this formula determine the z height of each point which characterise the layering
      z =  j * 30.mm * Math.sin(i / 5.0 * Math::PI * 4) * Math.sin((j / 9.0 + i/20.0) * Math::PI * 3) + i * 30.mm * Math.sin(k / 5.0 * Math::PI * 4) * Math.sin((j / 9.0 + i/20.0) * Math::PI * 3)
      #i * 20.mm + (i/5.0) * 30.mm * Math.sin(j / 5.0 * Math::PI * 3) * Math.sin((k / 9.0 + i/20.0) * Math::PI * 3) * j + k * 20.mm * Math.sin(j / 5.0 * Math::PI * 3) * Math.sin((k / 9.0 + i/20.0) * Math::PI * 3)
      #i * 20.mm + (i/5.0) * 30.mm * Math.sin(j / 5.0 * Math::PI * 2) * Math.sin((k / 9.0 + i/20.0) * Math::PI * 2)
      #+ rand(-1.0..1.0) * 20.mm
      # + 30.mm * Math.cos(j / 9.0 * Math::PI * 2) *  Math.cos((k / 9.0 + i / 18.0) * Math::PI * 2)
      # z ini juga bisa
      pt = Geom::Point3d.new(x, y, z)
      points.push(pt)
    end
  matrix.push(points)
  end

  # interate the point in matrix to create a surface
  a = 0
  single_layer = ent.add_group
  for row in matrix
    b = 0
    for item in row
      face = nil # empty variable "face"
      pts1 = matrix[a][b]
      row_pts23 = matrix[a+1]
      if row_pts23
        pts2 = row_pts23[b]
        pts3 = row_pts23[b+1]
      end
      if ((pts1 != nil) & (pts2 != nil) & (pts3 != nil))
        face = single_layer.entities.add_face(pts1, pts2, pts3)
      end
      pts4 = matrix[a][b]
      row_pts5 = matrix[a+1]
      if row_pts5
        pts5 = row_pts5[b+1]
      end
      pts6 = matrix[a][b+1]
      if ((pts4 != nil) & (pts5 != nil) & (pts6 != nil))
        face = single_layer.entities.add_face(pts4, pts5, pts6)
      end
      if face != nil # checking the direction of face
        if face.normal.z < 0
          face.reverse!
        end
      end
      b += 1
    end
    a += 1
  end
end
