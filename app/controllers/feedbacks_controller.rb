class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:destroy]

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @project = Project.find_by_hashed_id(params[:project_id])
    @feedback = @project.feedbacks.new(feedback_params)

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:content)
    end
end
