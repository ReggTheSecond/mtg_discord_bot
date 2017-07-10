require 'mtg_sdk'

class Card_Searcher
  def get_cards(name, type, subtype, text, colour, set)
    cards = MTG::Card.where(name: name)
                      .where(type: type)
                      .where(subtypes: subtype)
                      .where(text: text)
                      .where(colors: colour)
                      .where(set: set)
                      .where(page: 1).where(pageSize: 20)
                      .all
    return cards
  end

  def get_nickname_file()
    return File.open("data/nicknames.csv", 'r')
  end

  def clean_name(card_name)
    card_name = card_name.strip()
    card_name = card_name.split("[[").last()
    card_name = card_name.split("]]").first()
    card_name = card_name.split("{{").last()
    card_name = card_name.split("}}").first()
    card_name = card_name.split(":").first()
    card_name = card_name.downcase()
    return card_name
  end

  def is_a_nickname(name)
    file = get_nickname_file()
    file.each_line() do |line|
      if line.split("~").last().strip() == name
        return true
      end
    end
    file.close()
    return false
  end

  def get_nickname(name)
    file = get_nickname_file()
    file.each_line() do |line|
      if line.split("~").last().strip() == name
        return line.split("~").first
      end
    end
    file.close()
  end

  def get_split_card(card_name)
    left = card_name.split("//").first()
    left_cards = get_cards(left, "", "", "", "", "")
    left_cards.each() do |left_card|
      if left_card.name.downcase().strip() == left
        return left_card.image_url
      end
    end
  end

  def get_card_link(name)
    cards = get_cards(name, "", "", "", "", "")
    cards.each do |card|
      if card.name.downcase().strip() == name
        if card.image_url != nil && card.image_url != ""
          return card.image_url
        end
      end
    end
    return cards.last().image_url
  end

  def get_card_name(name)
    cards = get_cards(name, "", "", "", "", "")
    cards.each do |card|
      if card.name.downcase().strip() == name
        if card.name != nil && card.name != ""
          return card.name
        end
      end
    end
    return cards.last().name
  end

  def get_specific_set(name, set)
    name = clean_name(name)
    set = clean_name(set)
    cards = get_cards(name, "", "", "", "", set)
    cards.last().image_url
  end

  def get_card_sets(name)
    cards = get_cards(name, "", "", "", "", "")
    sets = ""
    cards.each do |card|
      sets = sets << card.set() << "\n"
    end
    return sets
  end

  def cards_with(name, type, subtype, text, colour, set)
    results = ""
    cards = get_cards(name, type, subtype, text, colour, set)
    cards.each() do |card|
      if !results.include?(card.name)
        results = results << "#{card.name}\n"
      end
    end
    return results
  end
end
