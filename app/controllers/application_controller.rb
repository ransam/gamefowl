class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_fowls

def after_sign_in_path_for(resource)
  sign_in_url = new_user_session_url
  if request.referer == sign_in_url
    super
  else
    stored_location_for(resource) || request.referer || root_path
  end
end

private
  def get_fowls
  	user = User.find_by(store_name: request.subdomain)
 
    if user.present?
      @fowls = user.fowls
    else
      if request.subdomain != "www"
        redirect_to root_url(subdomain: 'www')
      end
    end
  end

  # private

  # def current_user
  # 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # helper_method :current_user
end
