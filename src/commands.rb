require_relative 'whats_the_pick.rb'

class Commands
  def initialize()
    @current_list =  ""
  end

  def filter_commands(event)
    command = event.content.to_s()
    command = clean_command(command)
    puts command
    result = ""
    if command == "exit"
      shut_down_bot(event)
    elsif command == "readme" || command == "help"
      result = post_readme(event)
    elsif command.match(/^nickname:(.+)>>(.+)$/)
      result = create_card_nickname(command)
    elsif command.match(/^remove nickname:(.+)>>(.+)$/)
      result = remove_card_nickname(command)
    elsif command == "list nicknames"
      result = list_nicknames(event)
    elsif command.match(/^whatsthepick:...$/)
      WhatIsThePick.new(event, command.split(":").last().split(":").first())
    elsif command.match(/^request:(.+)$/)
      result = add_feature_request(command)
    elsif command.match(/^newdeck:(.+)$/) || command.match(/^new deck:(.+)$/)
      result = create_deck(event, command)
    elsif command.match(/^set deck:(.+)$/)  || command.match(/^setdeck:(.+)$/)
      result = set_deck(command)
    elsif command.match(/^which list$/)  || command.match(/^whichlist$/)
      result = which_list(event, command)
    elsif command.match(/^request list:(.+)$/)  || command.match(/^requestlist:(.+)$/)
      result = request_list(event, command)
    elsif command.match(/^card:(.+)$/)  || command.match(/^card:(.+)$/)
      result = add_card_to_deck(command)
    elsif command.match(/^listdecks$/)  || command.match(/^list decks$/)
      result = list_all_decks()
    else
      result = unknown_command(event)
    end
    event.respond result
  end

  def clean_command(command)
      command = command.strip()
      command = command.gsub("~", "")
      command = command.downcase()
      return command
  end

  def shut_down_bot(event)
      event.respond "Shutting down bot"
      exit
  end

  def post_readme(event)
    file = File.open("README", "r")
    readme = ""
    file.each_line do |line|
      readme = readme << line
    end
    file.close()
    return readme
  end

  def create_card_nickname(names)
    card_name = names.split(">>").first().split(":").last()
    nickname = names.split(">>").last().split(":").first()
    nickname_file = File.open("data/nicknames.csv", 'a+')
    nickname_file << "#{card_name}~#{nickname}\n"
    nickname_file.close()
    return "Nickname created for #{card_name}, nickname is #{nickname}"
  end

  def remove_card_nickname(names)
    card_name = names.split(">>").first().split(":").last().strip()
    nickname = names.split(">>").last().split(":").first().strip()
    nickname_file = File.open("data/nicknames.csv", 'a+')
    puts names
    new_file = ""
    nickname_file.each_line() do |line|
      if line.strip != "#{card_name}~#{nickname}"
        new_file = new_file << line
      end
    end
    nickname_file.truncate(0)
    nickname_file << new_file
    nickname_file.close()
    return "Nickname removed for #{card_name}, nickname is #{nickname}"
  end

  def list_nicknames(event)
    nickname_file = File.open("data/nicknames.csv", 'r+')
    nicknames = ""
    nickname_file.each_line do |line|
      nicknames = nicknames << line
    end
    return "Nicknames:\n#{nicknames}"
  end

  def add_feature_request(command)
    file = File.open("data/feature_requests.txt", "a+")
    request = "#{DateTime.now().strftime("%d/%m/%y")}:Feature: #{command.split(":").last().split(":").first()}"
    file << request
    file.close()
    return request
  end

  def create_deck(event, command)
    deck_name = command.split(":").last().strip()
    file = File.open("data/decklists/#{deck_name}.txt", "a+")
    file.close()
    set_deck(command)
    return "#{deck_name} created"
  end

  def set_deck(command)
    deck_name = command.split(":").last().strip()
    @current_list = deck_name
    puts @current_list
    return "#{@current_list}.txt"
  end

  def add_card_to_deck(command)
    card_name = command.split(":").last().strip()
    file = File.open("data/decklists/#{@current_list}.txt", "a+")
    file << "#{card_name}\n"
    file.close()
    return nil
  end

  def which_list(event, command)
    return "#{@current_list}.txt"
  end

  def request_list(event, command)
    deck_name = command.split(":").last().strip()
    decklist = ""
    file = File.open("data/decklists/#{deck_name}.txt", "a+")
    file.each_line do |line|
      decklist = decklist << line
    end
    event.author.pm(decklist)
    file.close()
    return nil
  end

  def list_all_decks()
    result = Dir.entries("data/decklists/")
    new_result = ""
    result.each do |line|
      if line.include?(".txt")
        new_result = new_result << line.split(".txt").first() << "\n"
      end
    end
    return new_result
  end

  def unknown_command(event)
    event.respond "This command is unknown. Please see the README for command list with: ~README~"
  end
end
