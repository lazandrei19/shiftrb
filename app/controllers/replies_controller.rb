class RepliesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @replies = Reply.all
  end

  # POST /replies
  # POST /replies.json
  def create
    @feedback = Feedback.find_by_hashed_id(params[:feedback_id])
    @reply = @feedback.replies.new(reply_params)
    @reply.user = current_user

    respond_to do |format|
      if @reply.save
        format.html { redirect_to :back, notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
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
