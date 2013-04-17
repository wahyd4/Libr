class WeiXinController < ApplicationController

  def verify
    echo_str = params[:echostr]
    render text: echo_str
  end

  def query
    xml_string = request.raw_post
    message = parse_xml(xml_string)

    reply_message = BasicMessage.new
    reply_message.create_time = Time.now.to_i
    reply_message.from_user = message.to_user
    reply_message.to_user = message.from_user
    reply_message.message_type = message.message_type
    reply_message.message_id=''
    reply_message.content = "Hello"

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.xml {
        xml.FromUserName reply_message.from_user
        xml.ToUserName reply_message.to_user
        xml.CreateTime reply_message.create_time
        xml.MsgType reply_message.message_type
        xml.Content reply_message.content
        xml.FuncFlag 0
      }
    end

    render xml: builder.to_xml
  end

  def parse_xml(xml_string)
    xml = Nokogiri::XML(xml_string)
    message = BasicMessage.new
    message.from_user = xml.xpath('//FromUserName').text
    message.to_user = xml.xpath('//ToUserName').text
    message.create_time = xml.xpath('//CreateTime').text
    message.message_type = xml.xpath('//MsgType').text
    message.content = xml.xpath('//Content').text
    message.message_id = xml.xpath('//MsgId').text
    message
  end
end
