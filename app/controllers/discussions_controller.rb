class DiscussionsController < ApplicationController
  def show
    @discussion = Discussion.find(params[:id])
    @project = @discussion.project
    @posts = @discussion.posts
    @post = Post.new
    @contributors = @posts.map(&:user).uniq

    @text = @project.text
    if @discussion.modification
      @modification_content = JSON.parse(@discussion.modification.content_after)["blocks"] - JSON.parse(@discussion.modification.content_before)["blocks"]
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @project_creator = @current_user == @project.user
    @discussions = Discussion.where(project_id: params[:project_id])
    @global_disc = @discussions.select { |d| d.modification_id.nil? }
    @opened_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status == "pending" }
    @closed_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status != "pending" }
  end
end
