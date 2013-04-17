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
        books = Book.order("RANDOM()").limit(5)
        reply_message = build_reply(message)
        builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8')  do |xml|
          xml.xml {
            xml.FromUserName reply_message.from_user
            xml.ToUserName reply_message.to_user
            xml.CreateTime reply_message.create_time
            xml.MsgType 'news'
            xml.ArticleCount{
              xml.cdata books.count
            }
            xml.Articles {
               books.each do |book|
                  xml.item {
                    xml.Title{
                      xml.cdata book.name
                    }
                    xml.Description{
                      xml.cdata book.author
                    }
                    xml.PicUrl {
                      xml.cdata book.image
                    }
                    xml.Url{
                      xml.cdata "http://libr.herokuapp.com/books/#{book.id}"
                    }
                  }
              end
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
    reply_message.content = "Hello Thoughtworks, please input 1 to see something defferent."

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
