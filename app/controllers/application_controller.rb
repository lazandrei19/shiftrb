class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :md_render

  def md_render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true, tables: true)
    markdown.render(text).html_safe
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
