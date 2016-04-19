class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  def like
    unless current_user.voted_for? @project
      @project.create_activity :like, owner: current_user
      @project.liked_by current_user
    else
      @activity = PublicActivity::Activity.find_by(trackable_id: (@project.id), key: "project.like")
      @activity.destroy
      @project.unliked_by current_user
    end
    redirect_to :back
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        @project.create_activity :create, owner: current_user
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
