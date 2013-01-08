require 'net/http'
require 'net/https'

module Douban_Auth


	def auth_url
		client_id = '0858f96ac849895e190aec4058dc9c1a'
		redirect_uri = 'http://localhost:3000/douban_callback'
		response_type = 'code'
		scope = 'douban_basic_common'

		url = 'https://www.douban.com/service/auth2/auth?client_id=' << client_id << '&redirect_uri=' << redirect_uri << '&response_type=' << response_type << '&scope='+ scope

	end

	def access_token(code)
		my_code =  'Bearer '+ code.to_s
		http = Net::HTTP.new('www.douban.com', 443)
		http.use_ssl = true
		path ='/service/auth2/token'
		data ='client_id=0858f96ac849895e190aec4058dc9c1a&client_secret=0c363bc78dbacb3f&redirect_uri=http://localhost:3000/douban_callback&grant_type=authorization_code&code='+code
		headers = {
				'Authorization' => my_code
		}

		response = http.post(path, data, headers)
		response = JSON.parse response.body
		puts '111111111111111111'+ response.to_s
	end
end