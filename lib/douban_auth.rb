require 'net/http'
require 'net/https'

module Douban_Auth


	def auth_url
		response_type = 'code'
		scope = 'douban_basic_common,book_basic_r'

		url = 'https://www.douban.com/service/auth2/auth?client_id=' + ::ENV['CLIENT_ID'] +
					'&redirect_uri=' + ::ENV['REDIRECT_URI'] +
				  '&response_type=' + response_type + '&scope=' + scope

	end

	def access_token(code)
		my_code =  'Bearer '+ code.to_s
		http = Net::HTTP.new('www.douban.com', 443)
		http.use_ssl = true
		path ='/service/auth2/token'
		data ='client_id='+ ::ENV['CLIENT_ID']+'&client_secret='+ ::ENV['CLIENT_SECRET']+'&redirect_uri='+::ENV['REDIRECT_URI']+'&grant_type=authorization_code&code='+code
		headers = {
				'Authorization' => my_code
		}

		response = http.post(path, data, headers)
		response = JSON.parse response.body
    puts "!!!!!!!!!!!!!!!!!!" + response.to_s
		response['access_token']
	end

	def fetch_user_info(token)
		http = Net::HTTP.new('api.douban.com', 443)
		http.use_ssl = true
		path ='/v2/user/~me'
		header = {
				"Authorization" => "Bearer #{token}"
		}
		response = http.get(path,header)
		response = JSON.parse response.body
	end

end