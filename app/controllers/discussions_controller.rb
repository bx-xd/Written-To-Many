class DiscussionsController < ApplicationController
  def show
  end

  def index
    @current_user = current_user
    @project = Project.find(params[:project_id])
    @project_creator = @current_user == @project.user
    @discussions = Discussion.where(project_id: params[:project_id])
    @global_disc = @discussions.select { |d| d.modification_id.nil? }
    @opened_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status == "pending" }
    @closed_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status != "pending" }
  end
end
