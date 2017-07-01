require 'mtg_sdk'

class Card_Searcher
  def get_cards(card_name)
    cards = MTG::Card.where(name: card_name).all
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

  def is_a_nickname(card_name)
    file = get_nickname_file()
    file.each_line() do |line|
      if line.split("~").last().strip() == card_name
        return true
      end
    end
    file.close()
    return false
  end

  def get_nickname(card_name)
    file = get_nickname_file()
    file.each_line() do |line|
      if line.split("~").last().strip() == card_name
        return line.split("~").first
      end
    end
    file.close()
  end

  def get_split_card(card_name)
    left = card_name.split("//").first()
    left_cards = get_cards(left)
    left_cards.each() do |left_card|
      if left_card.name.downcase().strip() == left
        return left_card.image_url
      end
    end
  end

  def get_card_link(card_name)
    cards = get_cards(card_name)
    cards.each do |card|
      if card.name.downcase().strip() == card_name
        if card.image_url != nil && card.image_url != ""
          return card.image_url
        end
      end
    end
    return cards.last().image_url
  end

  def get_card_name(card_name)
    cards = get_cards(card_name)
    cards.each do |card|
      if card.name.downcase().strip() == card_name
        if card.name != nil && card.name != ""
          return card.name
        end
      end
    end
    return cards.last().name
  end

  def get_specific_set(card_name, set)
    card_name = clean_name(card_name)
    set = clean_name(set)
    cards =  MTG::Card.where(name: card_name)
                      .where(set: set)
                      .all
    cards.last().image_url
  end

  def get_card_sets(card_name)
    cards = get_cards(card_name)
    sets = ""
    cards.each do |card|
      sets = sets << card.set() << "\n"
    end
    return sets
  end

  def cards_with(name, type, subtype, text, colour)
    results = ""
    cards =  MTG::Card.where(name: name)
                      .where(type: type)
                      .where(subtypes: subtype)
                      .where(text: text)
                      .where(colors: colour)
                      .where(page: 1).where(pageSize: 20)
                      .all
    cards.each() do |card|
      if !results.include?(card.name)
        results = results << "#{card.name}\n"
      end
    end
    return results
  end
end
