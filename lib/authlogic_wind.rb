require "authlogic_wind/acts_as_authentic"
require "authlogic_wind/session"
require "authlogic_wind/helper"

ActiveRecord::Base.send(:include, AuthlogicWind::ActsAsAuthentic)
Authlogic::Session::Base.send(:include, AuthlogicWind::Session)
ActionController::Base.helper AuthlogicWind::Helper