module FindByDayExtension
  def find_by_day time
    find(:all, :conditions => {
        :created_at => time.at_beginning_of_day..time.end_of_day}).first
  end
end
