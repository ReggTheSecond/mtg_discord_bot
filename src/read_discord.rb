require 'discordrb'
require_relative 'get_card.rb'
require_relative 'commands.rb'

def clean_card_name(card_name)
  card_name = card_name.strip()
  card_name = card_name.split("[[").last()
  card_name = card_name.split("]]").first()
  card_name = card_name.split(":").first()
  card_name = card_name.downcase()
  return card_name
end

command_centre = Commands.new()

token = ARGV[0]
client_id = ARGV[2]

bot = Discordrb::Bot.new token: token, client_id: client_id

bot.message(with_text: /~(.+)~/) do |event|
  command_centre.filter_commands(event)
end

bot.message(with_text: /\[\[(.+):sets\]\]/) do |event|
  card_name = event.content.to_s()
  event.respond "#{clean_card_name(card_name)}\n#{get_card_set(clean_card_name(card_name))}"
end

bot.message(with_text: /\[\[(.+)\]\]|(.+)\[\[(.+)\]\](.+)/) do |event|
  card_name = event.content.to_s()
  event.respond "#{get_card_link(clean_card_name(card_name))}"
end

bot.run
