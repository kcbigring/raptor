class HomeController < ApplicationController
  def index
    @photos = [] # initialize an array to hold photos
    if session[:omniauth]
      facebook = Facebook.new
      token = session[:omniauth]['credentials']['token']
      @photos = facebook.get_photos(token)
    end
  end
end