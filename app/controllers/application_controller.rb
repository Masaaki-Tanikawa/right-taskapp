class ApplicationController < ActionController::Base
  if Rails.env.production?
    # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    allow_browser versions: :modern
  end
	  # Deviseログイン後のリダイレクト先を指定
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

end

