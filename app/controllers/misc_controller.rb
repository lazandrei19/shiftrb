class MiscController < ApplicationController
  def discover
    @projects = Project.all.order("score DESC")
  end

  def clear
    current_user.unread = 0
    current_user.save
  end
end