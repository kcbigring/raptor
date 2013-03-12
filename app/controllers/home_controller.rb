class HomeController < ApplicationController
  def index
    @photos = []
    if session[:omniauth]
      facebook = Facebook.new
      token = session[:omniauth]['credentials']['token']
      logger.debug ">>>> token = #{token}"
      @photos = facebook.get_photos(token)
    end
  end
end