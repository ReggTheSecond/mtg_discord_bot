require 'mtg_sdk'

def get_cards(card_name)
  cards =  MTG::Card.where(name: card_name).all
end

def get_nickname_file()
  return File.open("data/nicknames.csv", 'r')
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
  if is_a_nickname(card_name)
    card_name = get_nickname(card_name)
  end
  left = card_name.split("//").first()
  right = card_name.split("//").last()
  left_cards = get_cards(left)
  left_cards.each() do |left_card|
    if left_card.name.downcase().strip() == left
      return left_card.image_url
    end
  end
end

def get_card_link(card_name)
  if is_a_nickname(card_name)
    card_name = get_nickname(card_name)
  end

  cards = get_cards(card_name)
  cards.each do |card|
    if card.name.downcase.strip == card_name
      return card.image_url
    end
  end
  return cards.last().image_url
end

def get_specific_set(card_name, set)
  cards =  MTG::Card.where(name: card_name)
                    .where(set: set)
                    .all
  cards.last().image_url
end

def get_card_sets(card_name)
  if is_a_nickname(card_name)
    card_name = get_nickname(card_name)
  end
  cards = get_cards(card_name)
  sets = ""
  cards.each do |card|
    sets = sets << card.set() << "\n"
  end
  return sets
end

def cards_with(search_for_name, search_for_text, search_for_colour)
  results = ""
  cards =  MTG::Card.where(name: search_for_name)
                    .where(text: search_for_text)
                    .where(colors: search_for_colour)
                    .where(page: 1).where(pageSize: 20)
                    .all
  cards.each() do |card|
    if !results.include?(card.name)
      results = results << "#{card.name}\n"
    end
  end
  return results
end
