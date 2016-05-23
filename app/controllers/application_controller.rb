class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render *args
    add_notifications
    super
  end

  def add_notifications
    if user_signed_in?
      @notifications = PublicActivity::Activity.order("created_at desc").where(recipient: current_user, key: ["feedback.createNotification", "feedback.likeNotification", "project.createNotification", "project.likeNotification"]).limit(5)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u| 
      u.permit(:email, :password, :password_confirmation, :name, :avatar, workplaces_attributes: [:id, :company, :position, :emoji, :_destroy])
    end
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:email, :password, :password_confirmation, :current_password, :name, :avatar, workplaces_attributes: [:id, :company, :position, :emoji, :_destroy])
    end
  end

  private

  def locals(values)
    render locals: values
  end
end
