class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	skip_before_filter :authenticate_user!

	def all
		p env["omniauth.auth"]
		user = User.from_omniauth(env["omniauth.auth"])
		if user.persisted?
			flash[:notice] = "You are in..!!! Go to edit profile to see the status for the accounts"
			sign_in_and_redirect(user)
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_url
		end
	end

	def failure
      #handle you logic here..
      #and delegate to super.
      super
  end


	alias_method :facebook, :all


end
