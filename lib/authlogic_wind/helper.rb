module AuthlogicWind
  module Helper
    def wind_login_url(controller_name)
      url_for(:controller => controller_name) + "/create?login_with_wind=true"
    end
  end
end