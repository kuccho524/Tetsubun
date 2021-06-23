class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # サインナップ後の遷移先
  def after_sign_up_path_for(resource)
    root_path
  end

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
