require_relative 'get_card.rb'
require 'mtg_sdk'

class WhatIsThePick
  @cards_in_pack
  def initialize(event, set)
    @cards_in_pack = ""
    produce_pack(event, set)
  end

  def produce_pack(event, set)
    index = 0
    commons_in_a_pack = 9
    uncommons_in_a_pack = 3
    commons = MTG::Card.where(set: set).where(rarity: "common").all
    uncommons = MTG::Card.where(set: set).where(rarity: "uncommon").all
    while index < commons_in_a_pack
      get_rnd_card(event, commons)
      index += 1
    end
    index = 0
    while index < uncommons_in_a_pack
      get_rnd_card(event, uncommons)
      index += 1
    end
    rare = MTG::Card.where(set: set).where(rarity: "rare").all
    get_rnd_card(event, rare)
  end

  def get_rnd_card(event, cards)
    number_of_cards = cards.size
    rng = Random.new()
    get_index_at = rng.rand(0...number_of_cards)
    while @cards_in_pack.include?(get_card_link(cards[get_index_at].name))
      puts "dup"
      get_index_at = rng.rand(0...number_of_cards)
    end
    @cards_in_pack << "#{get_card_link(cards[get_index_at].name)}\n"
    event.send_temp(get_card_link(cards[get_index_at].name), 60)
    sleep 1
  end
end
