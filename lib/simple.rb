module SimpleExtensions
  def range_map(value, istart, istop, ostart, ostop)
    ostart + (ostop - ostart) * (
        Float((value - istart)) / Float((istop - istart)))
  end

  def normalized_average average, new_value, old_units, new_units
    if new_units == old_units
      new_average = average - Float(average) / old_units
      new_average += Float(new_value) / old_units
    else
      new_average = Float(average) / new_units * old_units
      new_average += Float(new_value) / new_units * (new_units - old_units)
    end
  end
end
