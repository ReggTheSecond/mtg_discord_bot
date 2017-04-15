require 'discordrb'
require_relative 'get_card.rb'

def clean_card_name(card_name)
  card_name = card_name.strip()
  card_name = card_name.gsub("[", "")
  card_name = card_name.gsub("]", "")
  return card_name
end


bot = Discordrb::Bot.new token: 'token', client_id: client_id

bot.message(with_text: /\[\[(.+)\]\]/) do |event|
  card_name = event.content.to_s
  event.respond get_card_link(clean_card_name(card_name))
end

bot.run
