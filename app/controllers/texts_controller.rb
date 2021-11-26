class TextsController < ApplicationController
  def show
    @text = Text.find(params[:id])
    @modification = Modification.new(uuid: SecureRandom.alphanumeric(30))

    @modifications = @text.modifications

    @content = JSON.parse(@text.content)
    @modifications.each do |modif|
      @content["blocks"] = [JSON.parse(modif.content_after)["blocks"], @content["blocks"]].flatten.uniq
    end

    @project = @text.project
  end

  def update
    text = Text.find(params[:id])

    if text.update(text_params)
      respond_to do |format|
        format.html { redirect_to text_path(text) }
        format.text
      end
    else
      render "edit"
    end
  end

  private

  def text_params
    params.require(:text).permit(:content)
  end
end
