class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:destroy, :like]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @project = Project.find_by_hashed_id(params[:project_id])
    @feedback = @project.feedbacks.new(feedback_params)
    @feedback.user = current_user

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @project, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    if current_user.voted_for? @feedback
      @feedback.unliked_by current_user
    else
      @feedback.liked_by current_user
    end
    redirect_to :back
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
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
