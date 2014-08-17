module KajaNomination
  class App
    module ApplicationHelper

      def title
        [Setting.community, Setting.site_title].join(" | ")
      end

      def site_title
        [Setting.site_title, Setting.community].join(" of ")
      end

      def alert_class(name)
        "alert alert-" <<
          case name.to_sym
          when :notice
            "info"
          when :alert
            "danger"
          else
            name.to_s
          end
      end

    end

    helpers ApplicationHelper
  end
end
