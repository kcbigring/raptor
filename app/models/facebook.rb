class Facebook

  def get_photos(token)
    photos = []
    albums = get_albums(token)
    albums.each_with_index do |album, index|
      photos.concat page_photos(token, album['id'])
      break if index > 4
    end
    photos
  end
  
  private
  
  def page_photos(token, album_id, paging_url=nil)
    url = "https://graph.facebook.com/#{album_id}/photos?access_token=#{token}"
    Rails.logger.debug "photo url = #{url}"
    url = paging_url if paging_url

    data = get_facebook_response(url)
    resources = data['data'] if data
    if resources.count > 0
      if data['paging'] and data['paging']['next']
        resources.concat page_photos(token, album_id, data['paging']['next'])
      end
    end
    resources
  end
  
  def get_albums(token, next_url=nil)
    if next_url
      url = next_url
    else
      url = "https://graph.facebook.com/me/albums?access_token=#{token}"
    end
    albums_data = nil
    data = get_facebook_response(url)
    if data
      albums_data = data['data']
    end
    if data['paging'] and data['paging']['next']
      albums_data.concat get_albums(token, data['paging']['next'])
    end
    albums_data
  end

  def get_facebook_response(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = JSON.parse(http.request(request).body)
    if response['error']
      if response['error'] and response['error']['error_subcode'] == 463

        self.active = false
        self.save
      end
      throw("facebook api error: #{response['error']['message']}")
    end
    response
  end
  
end