class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :like]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def like
    unless current_user.voted_for? @project
      @project.create_activity :like, owner: current_user, recipient: @project.user
      @project.create_activity :likeNotification, owner: current_user, recipient: @project.user

      @project.user.unread += 1
      @project.user.save

      @project.liked_by current_user
    else
      @activity = PublicActivity::Activity.find_by(trackable_id: (@project.id), key: "project.like")
      @activityNotification = PublicActivity::Activity.find_by(trackable_id: (@project.id), key: "project.likeNotification")
      @activity.destroy
      @activityNotification.destroy

      @project.user.unread -= 1
      @project.user.save

      @project.unliked_by current_user
    end

    redirect_to :back
  end

  def show
    @project.increment! :score
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      @project.create_activity :create, owner: current_user
      members[:members].chomp.split(/\n/).reject(&:empty?).uniq.each do |member|
        user_hashed_id = /\/users\/(\w{16})/.match(member)[1]
        user = User.find_by_hashed_id(user_hashed_id)
        if user
          member = user.members.create
          @project.members << member
        end
      end
      
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      @project.members.delete_all
      members[:members].each_line do |member|
        @project.members.create(:user => User.find_by_hashed_id(/\/users\/(\w{16})/.match(member)[1]))
      end
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    
    redirect_to projects_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by_hashed_id(params[:id])
    end

    # Check if the user has permissions to destroy/delete the entry
    def authorized_user
      @project = current_user.projects.find_by_hashed_id(params[:id])
      redirect_to projects_path, notice: "Not authorized to edit this project" if @project.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :logo, :headline, :description, images_attributes: [:id, :image, :_destroy])
    end
    
    def members
      params.require(:project).permit(:members)
    end
end
