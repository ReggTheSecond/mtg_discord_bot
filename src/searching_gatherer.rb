class SearchGatherer
  def search_for_card(name, type, subtype, text, colour, event)
    results = cards_with(name, type, subtype, text, colour)
    results.each_line do |line|
      sleep 1
      event.send_temp(get_card_link(line), 60)
    end
  end

  def parse_search(event)
    name = parse_card_name(event.content.to_s())
    type = parse_card_type(event.content.to_s())
    subtype = parse_card_subtype(event.content.to_s())
    parse_card_type(event.content.to_s())
    text = parse_card_text(event.content.to_s())
    colour = parse_card_colour(event.content.to_s())

    search_for_card(name, type, subtype, text, colour, event)
  end

  def parse_card_name(to_parse)
    if to_parse.include?("name:")
      name = to_parse.split("}}").first.split("name:").last().split("&").first()
    else
      name = ""
    end
    return name
  end

  def parse_card_type(to_parse)
    if to_parse.include?("type:")
      type = to_parse.split("}}").first.split("type:").last().split("&").first()
    else
      type = ""
    end
    return type
  end

  def parse_card_subtype(to_parse)
    if to_parse.include?("sub:")
      subtype = to_parse.split("}}").first.split("sub:").last().split("&").first()
    else
      subtype = ""
    end
    return subtype
  end

  def parse_card_text(to_parse)
    if to_parse.include?("text:")
      text = to_parse.split("}}").first.split("text:").last().split("&").first()
    else
      text = ""
    end
    return text
  end

  def parse_card_colour(to_parse)
    if to_parse.include?("colour:")
      colour = to_parse.split("}}").first.split("colour:").last().split("&").first()
    else
      colour = ""
    end
    return colour
  end
end
