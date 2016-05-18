class MiscController < ApplicationController
  def discover
    @projects = Project.all.order("score DESC")
  end

  def clearNotif
    current_user.unread = 0
    current_user.save
    render nothing: true
  end

  def clearFirstTime
    session[:first_time] = false
    render nothing: true
  end
end