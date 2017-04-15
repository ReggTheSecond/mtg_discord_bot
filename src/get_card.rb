require 'mtg_sdk'
require 'json'

def get_card_link(card_name)
  cards =  MTG::Card.where(name: card_name).all
  cards.last.image_url
end
