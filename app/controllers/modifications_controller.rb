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
      Discussion.create(modification: @modification, title: "Nouvelle modification", project: @text.project)

      respond_to do |format|
        format.html { redirect_to text_path(@text), notice: "Votre modif a été envoyée !" }
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
