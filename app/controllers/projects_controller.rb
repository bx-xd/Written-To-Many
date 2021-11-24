class ProjectsController < ApplicationController
  def edit
  end

  def update
  end

  def new
    @project = Project.new
    @project.user = current_user
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    text = Text.new
    @project.text = text

    if @project.save && text.save
      redirect_to edit_text_path(@project.text)
    else
      redirect_to "new"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
