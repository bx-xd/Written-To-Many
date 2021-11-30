class ModificationsController < ApplicationController
  def show
  end

  def create
    @modification = Modification.new(modification_params)
    @text = Text.find(params[:text_id])

    @modification.text = @text
    @modification.user = current_user

    @modification.status = "pending"


    if @modification.save
      @discussion = Discussion.create(modification: @modification, title: "Nouvelle modification", project: @text.project)

      diff = JSON.parse(@modification.content_after)["blocks"] - JSON.parse(@modification.content_before)["blocks"]
      data = JSON.parse(@modification.content_after)

      diff.each do |modif_block|
        block = data["blocks"].find { |block| block["id"] == modif_block["id"] }
        block["data"]["class"] = "custom-modification"
        block["data"]["id"] = @modification.id
      end

      @modification.content_after = data.to_json

      @modification.save


      respond_to do |format|
        format.html { redirect_to discussion_path(@discussion), notice: "Votre modif a été envoyée !" }
        format.text
      end
    else
      render "texts/show"
    end
  end

  def update
    @modification = Modification.find(params[:id])
    @modification.update(context: modification_params[:context], title: modification_params[:title])
    @modification.discussion.update(context: modification_params[:context], title: modification_params[:title])

    redirect_to discussion_path(@modification.discussion)
  end

  def validate
    @modification = Modification.find(params[:id])
    @modification.update(status: "accepted")
    redirect_to discussion_path(@modification.discussion)
  end

  def deny
    @modification = Modification.find(params[:id])
    @modification.update(status: "denied")
    redirect_to discussion_path(@modification.discussion)
  end

  private

  def modification_params
    params.require(:modification).permit(:content_after, :content_before, :uuid, :context, :title)
  end
end
