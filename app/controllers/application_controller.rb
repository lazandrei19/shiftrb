class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u| 
      u.permit(:email, :password, :password_confirmation, :name, :avatar, :skill_list, :experience_list, workplaces_attributes: [:id, :company, :position, :emoji, :_destroy])
    end
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:email, :password, :password_confirmation, :current_password, :name, :avatar, :skill_list, :experience_list, workplaces_attributes: [:id, :company, :position, :emoji, :_destroy])
    end
  end

  private

  def locals(values)
    render locals: values
  end
end
