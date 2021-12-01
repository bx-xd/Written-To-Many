class ProjectsController < ApplicationController
  def edit
  end

  def update
  end

  def new
    @project = Project.new
    @project.user = current_user
    @user = @project.user
    @contributions = @user.projects_contributions
    @projects = @user.projects
    @character = compting_writing_character
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    text = Text.new(content: "{\"blocks\": []}")
    @project.text = text

    if @project.save && text.save
      redirect_to text_path(@project.text)
    else
      redirect_to "new"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :photo)
  end

  def compting_writing_character
    compteur = 0
    @projects.each do |project|
      compteur += project.text.content.length unless project.text.content.nil?
    end

    @user.modifications.each do |modification|
      if (modification.content_after.length - modification.content_before.length).positive?
        compteur += modification.content_after.length - modification.content_before.length
      end
    end
    return compteur
  end
end
