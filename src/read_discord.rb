require 'discordrb'
require_relative 'get_card.rb'
require_relative 'commands.rb'
require_relative 'searching_gatherer.rb'

def prepare_card(card_name)
  searcher = Card_Searcher.new()
  card_name = searcher.clean_name(card_name)
  if searcher.is_a_nickname(card_name)
    card_name = searcher.get_nickname(card_name)
  end
  return card_name
end

def get_set(card_name)
  return card_name.split(":").last().downcase()
end

command_centre = Commands.new()
card_searcher = Card_Searcher.new()
search_gatherer = SearchGatherer.new()

token = ARGV[0]
client_id = ARGV[2]

bot = Discordrb::Bot.new token: token, client_id: client_id

bot.message(with_text: /\[\[|\{\{|~/) do |event|
  puts event.content.to_s()
end

bot.message(with_text: /~(.+)~/) do |event|
  command_centre.filter_commands(event)
end

bot.message(with_text: /(|(.+))\[\[(.+)\]\]((.+)|)/) do |event|
    card_name = event.content.to_s()
    card_name = prepare_card(card_name)
    case event.content.to_s()
    when /\/\//
      event.respond card_searcher.get_split_card(card_name)
    when /\[\[(.+):sets:\]\]/
      event.respond card_searcher.get_card_sets(card_name)
    when /\[\[(.+):(...)\]\]/
      set = get_set(card_name)
      event.respond card_searcher.get_specific_set(card_name, set)
    else
      event.respond card_searcher.get_card_link(card_name)
    end
end

bot.message(with_text: /\{\{(.+)\}\}/) do |event|
  search_gatherer.parse_search(event)
end

bot.run
