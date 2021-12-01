class TextsController < ApplicationController
  def show
    @text = Text.find(params[:id])
    @modification = Modification.new(uuid: SecureRandom.alphanumeric(30))

    @modifications = @text.modifications.where.not(status: "denied")

    @content = JSON.parse(@text.content)

    before_ids = JSON.parse(@text.content)["blocks"].map { |block| block["id"] }

    @modifications = @modifications.to_a.map do |modif|
      if modif.status == "accepted"
        data = JSON.parse(modif.content_after)
        data["blocks"].each do |block|
          unless before_ids.include? block["id"]
            block["accepted"] = true
          end
        end
        modif.content_after = data.to_json
        modif
      else
        modif
      end
    end

    @modifications.each do |modif|
      @content["blocks"] = [JSON.parse(modif.content_after)["blocks"], @content["blocks"]].flatten.uniq { |block| block["id"] }
      @modifications.each do |modif|
        modif_before_ids = JSON.parse(modif.content_before)["blocks"].map { |block| block["id"] }

        JSON.parse(modif.content_after)["blocks"].each do |block|
          unless modif_before_ids.include? block["id"]
            relevant_block = @content["blocks"].find { |content_block| content_block["id"] == block["id"] }
            relevant_block["accepted"] = block["accepted"] if relevant_block
          end
        end
      end
    end

    @content["blocks"].each do |block|
      unless before_ids.include?(block["id"])
        if block["accepted"]
          block["data"]["class"] = "accepted"
        else
          block["data"]["class"] = "custom-modification"
        end
      end
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
