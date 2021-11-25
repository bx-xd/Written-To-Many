class TextsController < ApplicationController
  def show
    @text = Text.find(params[:id])
    @modification = Modification.new(content_after: @text.content, content_before: @text.content)
    @project = @text.project
  end

  def update
    text = Text.find(params[:id])

    if text.update(text_params)
      redirect_to text_path(text)
    else
      render "edit"
    end
  end

  private

  def text_params
    params.require(:text).permit(:content)
  end
end
