class RepliesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @replies = Reply.all
  end

  def create
    @feedback = Feedback.find_by_hashed_id(params[:feedback_id])
    @reply = @feedback.replies.new(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to :back
    else
      redirect_to @project
    end
  end

  private
    # Check if the user has permissions to destroy/delete the entry
    def authorized_user
      @feedback = current_user.feedbacks.find_by_hashed_id(params[:id])
      redirect_to feedbacks_path, notice: "Not authorized to edit this feedback" if @feedback.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content)
    end
end
