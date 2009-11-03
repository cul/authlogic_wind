class WindCallbackFilter
  def initialize(app)
    @app = app
  end
  
  def call(env)
    unless env["rack.session"][:wind_callback_method].blank?
      # env["QUERY_STRING"].gsub!(/ticketid\=/,"user_session[ticketid]=")
      env["REQUEST_METHOD"] = env["rack.session"].delete(:wind_callback_method).to_s.upcase
    end
    @app.call(env)
  end
end