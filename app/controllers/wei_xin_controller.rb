class WeiXinController < ApplicationController

  def verify
    echo_str = params[:echostr]
    render text:echo_str
  end
end
