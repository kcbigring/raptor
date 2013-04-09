class PhotosController < ApplicationController
  def show
    @url = params[:url]
  end
end