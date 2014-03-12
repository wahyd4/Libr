class Api::V1::SessionsController < Devise::SessionsController


  before_filter :allow_cors
  #skip_before_filter :verify_authenticity_token

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :json => {
        success: true,
        user: {
            token: current_user.auth_keys.last.value,
            avatar: current_user.avatar,
            name: current_user.preferred_name ? current_user.preferred_name : '匿名'
        }

    }
  end


  def destroy
    sign_out(resource_name)
  end

  def failure
    render :json => {:success => false, :errors => current_user.errors}
  end

end
