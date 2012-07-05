KajaNomination.helpers do

  def title
    [Setting.site.community, Setting.site.title].join(" | ")
  end

  def site_title
    [Setting.site.title, Setting.site.community].join(" of ")
  end

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
