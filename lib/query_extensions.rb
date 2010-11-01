module FindByDayExtension
  def find_by_day time=nil
    time ||= Time.now.utc
    find(:all, :conditions => {
        :created_at => time.at_beginning_of_day..time.end_of_day}).first
  end
end

module FindNearestCityExtension
  def find_nearest x, y
    shortest_distance = nil
    nearest = nil
    find(:all).each do |city|
      distance = city.distance x, y
      if shortest_distance == nil or distance < shortest_distance
        shortest_distance = distance
        nearest = city
      end
    end
    nearest
  end

  def find_nearest_to_city city
    find_nearest city.x, city.y
  end
end

module FindLatestExtension
  def latest
    order("created_at DESC")
  end
end

module FindExistingExtension
  def find_existing_at time
    time ||= Time.now.utc
    find(:all, :readonly => false, :conditions => ["created_at <= ?", time])
  end
end