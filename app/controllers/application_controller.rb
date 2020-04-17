class ApplicationController < ActionController::Base

  # def after_sign_out_path_for(resource)
  #   root_path # ログアウト後に遷移するpathを設定
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:surname,:name_kana,:surname_kana,:postal_code,:phone_number,:address])
  end


  def after_sign_in_path_for(resource)

	  case resource
		  when Admin
		   admin_items_path
		  when EndUser
 		   end_user_path
 	   end
  end

end
