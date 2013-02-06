require 'net/http'
require 'net/https'

module QQAuth
  def qq_auth_url
    response_type = 'code'
    scope = 'get_user_info'

    url = 'https://graph.qq.com/oauth2.0/authorize?client_id=' + ::ENV['QQ_CLIENT_ID'] +
        '&redirect_uri=' + ::ENV['QQ_REDIRECT_URI'] +
        '&response_type=' + response_type +
        '&scope=' + scope + "&state=libr_test"

  end

  def qq_auth_token(code)
    http = Net::HTTP.new('graph.qq.com', 443)
    http.use_ssl = true
    path ='/oauth2.0/token?' +
        '&client_id='+ ::ENV['QQ_CLIENT_ID']+
        '&client_secret='+ ::ENV['QQ_CLIENT_SECRET']+
        '&redirect_uri='+::ENV['QQ_REDIRECT_URI']+
        '&grant_type=authorization_code&code='+code

    response = http.get(path)
    response = JSON.parse response.body
    response['access_token']

  end

  def fetch_qq_open_id(access_token)
    http = Net::HTTP.new('graph.qq.com', 443)
    http.use_ssl = true
    path ='/oauth2.0/me?' +
        '&access_token='+access_token

    response = http.get(path)
    response = JSON.parse response.body
    response['openid']
  end

  def fetch_qq_user_info(access_token, openid)
    http = Net::HTTP.new('graph.qq.com', 443)
    http.use_ssl = true
    path ='/user/get_user_info?' +
        '&access_token='+access_token +
        '&oauth_consumer_key=' +::ENV['QQ_CLIENT_ID'] +
        '&openid=' +openid
    response = http.get(path)
    response = JSON.parse response.body
    puts "response====" +response.to_s
    response

  end
end