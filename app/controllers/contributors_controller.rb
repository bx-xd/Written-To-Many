class ContributorsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @users = User.all.to_a
    @users.reject! { |user| user.projects_contributions.include?(@project) }
    @users.map! { |user| [user.id, user.username] }
    @contributor = Contributor.new
  end

  def create
    @project = Project.find(params[:project_id])
    @user = User.find(params[:contributor][:user_id])
    puts @user
    @contributor = Contributor.new(user: @user, project: @project)

    if @contributor.save
      flash[:notice] = "#{@user.username} à bien été ajouté aux contributeurs"
    else
      flash[:notice] = "Erreur, #{@user.username} n'a pas été ajouté aux contributeurs"
    end

    redirect_to new_project_contributor_path(@project)
  end
end
