Date::DATE_FORMATS.merge!(
  :default => Date::DATE_FORMATS[:long],
)

Time::DATE_FORMATS.merge!(
  :default => " %b %e, %Y %I:%M%p",
)
