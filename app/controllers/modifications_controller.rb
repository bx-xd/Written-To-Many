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
        block["data"]["id"] = @discussion.id
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
  end

  def validate
  end

  def deny
  end

  private

  def modification_params
    params.require(:modification).permit(:content_after, :content_before, :uuid)
  end
end
