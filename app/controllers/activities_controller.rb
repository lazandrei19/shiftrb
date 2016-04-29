class ActivitiesController < ApplicationController
  def index
    if user_signed_in?
      @activities = PublicActivity::Activity.order("created_at desc").where(owner: current_user.following, key: ["feedback.create", "project.create", "project.like"])
      @notifications = PublicActivity::Activity.order("created_at desc").where(recipient: current_user, key: ["feedback.createNotification", "feedback.likeNotification", "project.createNotification", "project.likeNotification"]).limit(5)
    else
      render "landing"
    end
  end

  def notifications
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient: current_user, key: ["feedback.createNotification", "feedback.likeNotification", "project.createNotification", "project.likeNotification"])
  end
end
