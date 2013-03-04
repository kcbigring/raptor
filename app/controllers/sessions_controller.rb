class SessionsController < ApplicationController
  def create
    session[:omniauth] = env["omniauth.auth"]
    redirect_to root_url
  end
end