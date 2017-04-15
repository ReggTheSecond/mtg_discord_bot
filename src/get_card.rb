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

def get_card_link(card_name)
  if is_a_nickname(card_name)
    card_name = get_nickname(card_name)
  end
  cards = get_cards(card_name)
  if !card_name.include?(":sets")
    return cards.last().image_url
  end
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
