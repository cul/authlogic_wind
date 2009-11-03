module AuthlogicWind
  module Helper
    def wind_login_link(session_class, controller_name, options = {})
      callback = url_for(:only_path => false, :controller => controller_name) + "/create"
      link_to (options[:name] || "Login"), url_for(:host => session_class.wind_host, :controller => "login", :protocol => "https", :service => session_class.wind_service, :destination => callback)

      
    end
  end
end