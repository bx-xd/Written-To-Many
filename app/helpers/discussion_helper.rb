module DiscussionHelper

  # permet d'afficher le content de la modif avec des balises correspondantes
  # aux blocks et leur type
  def block_to_html(block)
    letter = block["type"][0]

    level = letter == "h" ? block["data"]["level"] : nil

    return "<#{letter}#{level}>#{block['data']['text']}</#{letter}#{level}>"
  end
end
