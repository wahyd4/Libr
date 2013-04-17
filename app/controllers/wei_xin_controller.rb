class WeiXinController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:query]

  def verify
    echo_str = params[:echostr]
    render text: echo_str
  end

  def query
    message = parse_xml_to_hash(params[:xml])
    case message.content
      when '1'
        book = Book.order("RANDOM()").first
        reply_message = build_reply(message)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.xml {
            xml.FromUserName reply_message.from_user
            xml.ToUserName reply_message.to_user
            xml.CreateTime reply_message.create_time
            xml.MsgType 'news'
            xml.ArticleCount 1
            xml.Articles {
                xml.item {
                  xml.Title book.name
                  xml.Description book.author
                  xml.PicUrl book.image
                }
            }
          }
        end
        result = builder.to_xml
      else
        result = reply_text_message(message)
    end

    render xml: result
  end

  def reply_text_message(message)
    reply_message = build_reply(message)
    reply_message.content = "Hello Thoughtworks"

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
    builder.to_xml
  end

  def build_reply(message)
    reply_message = BasicMessage.new
    reply_message.create_time = Time.now.to_i
    reply_message.from_user = message.to_user
    reply_message.to_user = message.from_user
    reply_message.message_type = message.message_type
    reply_message
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
    message.save
    message
  end

  def parse_xml_to_hash(xml)
    message = BasicMessage.new
    message.from_user = xml[:FromUserName]
    message.to_user = xml[:ToUserName]
    message.create_time = xml[:CreateTime]
    message.message_type = xml[:MsgType]
    message.content = xml[:Content]
    message.message_id = xml[:MsgId]
    message.save
    message
  end
end
