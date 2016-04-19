class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow]
  before_action :authenticate_user!, only: [:follow]

  def index
    @users = User.all
  end

  def follow
    unless current_user.following? @user
      current_user.follow @user
    else
      current_user.unfollow @user
    end
    redirect_to :back
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_hashed_id(params[:id])
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
