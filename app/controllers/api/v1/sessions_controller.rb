class Api::V1::SessionsController < Devise::SessionsController


  before_filter :allow_cors
  #skip_before_filter :verify_authenticity_token

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :json => {
        success: true,
        user: {
            id: current_user.id,
            token: current_user.auth_keys.last.value,
            avatar: current_user.avatar,
            name: current_user.preferred_name ? current_user.preferred_name : '匿名'
        }, status: :ok

    }
  end


  def destroy
    sign_out(resource_name)
  end

  def failure

    render :json => {:success => false, :errors => '用户名或者密码错误,请重试'}, status: :forbidden
  end

end
