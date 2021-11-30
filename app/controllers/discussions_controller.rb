class DiscussionsController < ApplicationController
  def show
    @discussion = Discussion.find(params[:id])
    @modification = @discussion.modification
    @project = @discussion.project
    @posts = @discussion.posts
    @post = Post.new
    @contributors = @posts.map(&:user).uniq

    @text = @project.text

    # Permet d'afficher ce qui est PROPRE à la modif'
    if @discussion.modification
      @modification_content = JSON.parse(@discussion.modification.content_after)["blocks"] - JSON.parse(@discussion.modification.content_before)["blocks"]
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @project_creator = current_user == @project.user
    @discussions = Discussion.where(project_id: params[:project_id])
    @global_disc = @discussions.select { |d| d.modification_id.nil? }
    @opened_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status == "pending" }
    @closed_modif_disc = @discussions.select { |d| d.modification_id.present? && d.modification.status != "pending" }
    @discussion = Discussion.new
  end

  def create
    @project = Project.find(params[:project_id])
    @discussion = Discussion.new(disc_params)
    @discussion.project = @project

    if @discussion.save
      redirect_to discussion_path(@discussion)
    else
      render "discussions/index"
    end
  end

  private

  def disc_params
    params.require(:discussion).permit(:title, :context)
  end
end
