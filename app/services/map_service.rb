class MapService

  def getLocation(lat, lng)
    addr = "#{lat},#{lng}"
    RestClient.get 'http://api.map.baidu.com/geocoder',
                   {:params => {output: 'json',
                                key: ENV["BAIDU_MAP_KEY"],
                                location: addr
                   }}
  end

end