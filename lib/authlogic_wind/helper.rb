module AuthlogicWind
  module Helper
    def wind_login_url(controller_name)
      url_for(:controller => controller_name) + "/new?login_with_wind=true&return_to=#{CGI.escapeHTML(request.request_uri)}"
    end
  end
end