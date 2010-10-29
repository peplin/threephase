module CoordinateDistance
  def coordinate_distance x, y, other_x, other_y
    Math.sqrt(((other_x - x) ** 2) + ((other_y - y) ** 2))
  end
end
