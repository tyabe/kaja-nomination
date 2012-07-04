KajaNomination.helpers do

  def alert_message(name)
    "alert-" <<
      case name.to_sym
      when :notice
        "info"
      when :alert
        "error"
      else
        name.to_s
      end
  end

end
