class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(owner: current_user.following, key: ["feedback.create", "project.create", "project.like"])
  end

  def notifications
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient: current_user, key: ["feedback.createNotification", "feedback.likeNotification", "project.createNotification", "project.likeNotification"])
  end
end
