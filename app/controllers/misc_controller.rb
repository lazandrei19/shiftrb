class MiscController < ApplicationController
  def discover
    @projects = Project.all.order("score DESC")
  end
end