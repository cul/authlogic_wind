require 'net/http'
require 'net/https'

# This module is responsible for adding wind functionality to Authlogic. Checkout the README for more info and please
# see the sub modules for detailed documentation.
module AuthlogicWind
  # This module is responsible for adding in the wind functionality to your models. It hooks itself into the
  # acts_as_authentic method provided by Authlogic.
  module ActsAsAuthentic
    # Adds in the neccesary modules for acts_as_authentic to include and also disabled password validation if
    # wind is being used.
    def self.included(klass)
      klass.class_eval do
        extend Config
        add_acts_as_authentic_module(Methods, :prepend)
      end
    end
    
    module Config
      # The name of the wind login field in the database.
      #
      # * <tt>Default:</tt> :wind_login, :login, or :username, if they exist
      # * <tt>Accepts:</tt> Symbol
      def wind_login_field(value = nil)
        rw_config(:wind_login_field, value, first_column_to_exist(nil, :wind_login, :login, :username))
      end
      alias_method :wind_login_field=, :wind_login_field

      # Whether or not to validate the wind_login field. If set to false ALL wind validation will need to be
      # handled by you.
      #
      # * <tt>Default:</tt> true
      # * <tt>Accepts:</tt> Boolean
      def validate_wind_login(value = nil)
        rw_config(:validate_wind_login, value, true)
      end
      alias_method :validate_wind_login=, :validate_wind_login


      def find_by_wind_login_field(login)
        find(wind_login_field, login)
      end
    end
    
    module Methods
      # Set up some simple validations
      def self.included(klass)
        klass.class_eval do
          validate :validate_by_wind, :if => :authenticating_with_wind?

          validates_uniqueness_of :wind_login, :scope => validations_scope, :if => :using_wind?
          validates_length_of_password_field_options validates_length_of_password_field_options.merge(:if => :validate_password_with_wind?)
          validates_confirmation_of_password_field_options validates_confirmation_of_password_field_options.merge(:if => :validate_password_with_wind?)
          validates_length_of_password_confirmation_field_options validates_length_of_password_confirmation_field_options.merge(:if => :validate_password_with_wind?)
          
          
        end
      end

      
      
      private
      
      def authenticating_with_wind?
        
        # Controller isn't available in all contexts (e.g. irb)
        return false unless session_class.controller
        
        # Initial request when user presses one of the button helpers
        (session_class.controller.params && !session_class.controller.params[:login_with_wind].blank?) ||
        # When the oauth provider responds and we made the initial request
        (defined?(wind_response) && wind_response && session_class.controller.session && session_class.controller.session[:wind_request_class] == self.class.name)
      end
      
      def validate_password_with_wind?
        !using_wind? && require_password?
      end

      def using_wind?
        !wind_login.blank?
      end
    end
  end
end