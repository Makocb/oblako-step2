class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    render :json => Project.all.to_json(:include => :todos )
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    render :json => @project
  end

  # POST /projects
  # POST /projects.json
  def create
    params.permit!
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    params.permit!
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update_todo
      todo = Todo.where({ :project_id => params[:pid], :id => params[:tid]})
      todo.update(isCompleted: JSON.parse(request.body.read)["isCompleted"])
      render json: todo
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:project, {})
    end
end
