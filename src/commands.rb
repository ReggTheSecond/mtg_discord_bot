require_relative 'whats_the_pick.rb'

class Commands
  def filter_commands(event)
    command = event.content.to_s()
    command = clean_command(command)
    request = ""
    if command == "exit"
      shut_down_bot(event)
    elsif command == "readme"
      result = post_readme(event)
    elsif command.match /^nickname:(.+)>>(.+):$/
      result = create_card_nickname(event, command)
    elsif command.match /^remove nickname:(.+)>>(.+):$/
      result = remove_card_nickname(event, command)
    elsif command == "list nicknames"
      result = list_nicknames(event)
    elsif command.match /^whatsthepick:...:$/
      WhatIsThePick.new(event, command.split(":").last().split(":").first())
    elsif command.match ~request:(.+):~
      result = feature_requests(command)
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

  def create_card_nickname(event, names)
    card_name = names.split(">>").first().split(":").last()
    nickname = names.split(">>").last().split(":").first()
    nickname_file = File.open("data/nicknames.csv", 'a+')
    nickname_file << "#{card_name}~#{nickname}\n"
    nickname_file.close()
    return "Nickname created for #{card_name}, nickname is #{nickname}"
  end

  def remove_card_nickname(event,names)
    card_name = names.split(">>").first().split(":").last()
    nickname = names.split(">>").last().split(":").first()
    nickname_file = File.open("data/nicknames.csv", 'a+')
    puts names
    new_file = ""
    nickname_file.each_line() do |line|
      if line.strip != "#{card_name}~#{nickname}"
        new_file = new_file << line
      end
    end
    nickname_file.close()
    return "Nickname removed for #{card_name}, nickname is #{nickname}"
  end

  def list_nicknames(event)
    nickname_file = File.open("data/nicknames.csv", 'r+')
    nicknames = ""
    nickname_file.each_line do |line|
      nicknames = nicknames << line
    end
    return "Nickames:\n#{nicknames}"
  end

  def add_feature_request(command)
    file = File.open("data/feature_requests.txt", "a+")
    request = "#{DateTime.now().strftime("%d/%m/%y")}:Feature: #{command.split(":").last().split(":").first()}"
    file << request
    file.close()
    return request
  end

  def unknown_command(event)
    event.respond "This command is unknown. Please see the README for command list with: ~README~"
  end
end
