class DashboardsController < ApplicationController
  def show
    @user = current_user
    @projects = @user.projects
    @contributions = @user.projects_contributions
  end
end
