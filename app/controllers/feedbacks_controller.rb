class FeedbacksController < ApplicationController
  before_action :set_feedback, only: :like
  before_action :authenticate_user!

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @project = Project.find_by_hashed_id(params[:project_id])
    @project.score += 5
    @project.save
    @feedback = @project.feedbacks.new(feedback_params)
    @feedback.user = current_user

    if @feedback.save
      @feedback.create_activity :create, owner: current_user, recipient: @feedback.project.user
      @feedback.create_activity :createNotification, owner: current_user, recipient: @feedback.project.user
      redirect_to @project
    else
      redirect_to @project
    end
  end

  def like
    unless current_user.voted_for? @feedback
      @feedback.liked_by current_user
      @feedback.create_activity :likeNotification, owner: current_user, recipient: @feedback.user
    else
      @activity = PublicActivity::Activity.find_by(trackable_id: (@feedback.id), key: "feedback.likeNotification")
      @activity.destroy
      @feedback.unliked_by current_user
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find_by_hashed_id(params[:id])
    end

    # Check if the user has permissions to destroy/delete the entry
    def authorized_user
      @feedback = current_user.feedbacks.find_by_hashed_id(params[:id])
      redirect_to feedbacks_path, notice: "Not authorized to edit this feedback" if @feedback.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:content)
    end
end
