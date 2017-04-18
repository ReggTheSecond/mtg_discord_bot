require 'discordrb'
require_relative 'get_card.rb'
require_relative 'commands.rb'
require_relative 'searching_gatherer.rb'

def clean_text(card_name)
  card_name = card_name.strip()
  card_name = card_name.split("[[").last()
  card_name = card_name.split("]]").first()
  card_name = card_name.split("{{").last()
  card_name = card_name.split("}}").first()
  card_name = card_name.downcase()
  return card_name
end

def get_set(card_name)
  return card_name.split(":").last().downcase()
end

command_centre = Commands.new()
search = SearchGatherer.new()

token = ARGV[0]
client_id = ARGV[2]

bot = Discordrb::Bot.new token: token, client_id: client_id

bot.message(with_text: /\[\[|\{\{|~/) do |event|
  puts event.content.to_s()
end

bot.message(with_text: /~(.+)~/) do |event|
  command_centre.filter_commands(event)
end

bot.message(with_text: /(.+)\]\]|(.+)\[\[(.+)\]\](.+)/) do |event|
    case event.content.to_s()
    when /\/\//
      card_name = event.content.to_s()
      event.respond get_split_card(card_name)
    when /\[\[(.+):sets:\]\]/
      card_name = event.content.to_s()
      event.respond get_card_sets(card_name)
    when /\[\[(.+):(...)\]\]/
      card_name = event.content.to_s()
      set = get_set(card_name)
      event.respond get_specific_set(card_name, set)
    else
      card_name = event.content.to_s()
      event.respond get_card_link(card_name)
    end
end

bot.message(with_text: /\{\{(.+)\}\}/) do |event|
  search.parse_search(event)
end

bot.run
