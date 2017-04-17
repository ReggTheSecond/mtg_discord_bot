class SearchGatherer
  def search_for_card(search_for_name,search_for_text,search_for_colour, event)
    results = cards_with(search_for_name, search_for_text, search_for_colour)
    results.each_line do |line|
      sleep 1
      event.respond get_card_link(line.strip)
    end
  end

  def parse_card_name(to_parse)
    name = to_parse.split("}}").first.split("&").first().split(":").last()
  end

  def parse_card_text(to_parse)
    text = to_parse.split("}}").first.split("text:").last().split("&colour").first()
  end

  def parse_card_type(to_parse)
    type = to_parse.split("}}").first.split("type:").last().split("&text").first().split("&colour").first()
  end

  def parse_card_colour(to_parse)
    colour = to_parse.split("}}").first.split("colour:").last()
  end
end
