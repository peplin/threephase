module SimpleExtensions
  def range_map(value, istart, istop, ostart, ostop)
    ostart + (ostop - ostart) * (
        Float((value - istart)) / Float((istop - istart)))
  end
end
