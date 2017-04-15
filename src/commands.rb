class Commands
  def filter_commands(event)
    command = event.content.to_s()
    command = clean_command(command)
    if command == "exit"
      shut_down_bot(event)
    elsif command == "readme"
      post_readme(event)
    elsif command.match /^nickname:(.+)>>(.+):$/
      create_card_nickname(event, command)
    elsif command.match /^remove nickname:(.+)>>(.+):$/
      remove_card_nickname(event, command)
    elsif command == "list nicknames"
      list_nicknames(event)
    else
      unknown_command(event)
    end
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
    event.respond readme
  end

  def create_card_nickname(event, names)
    card_name = names.split(">>").first().split(":").last()
    nickname = names.split(">>").last().split(":").first()
    nickname_file = File.open("data/nicknames.csv", 'a+')
    nickname_file << "#{card_name}~#{nickname}\n"
    nickname_file.close()
    event.respond "Nickname created for #{card_name}, nickname is #{nickname}"
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
    event.respond "Nickname removed for #{card_name}, nickname is #{nickname}"
  end

  def list_nicknames(event)
    nickname_file = File.open("data/nicknames.csv", 'r+')
    nicknames = ""
    nickname_file.each_line do |line|
      nicknames = nicknames << line
    end
    event.respond "Nickames:\n#{nicknames}"
  end

  def unknown_command(event)
    event.respond "This command is unknown. Please see the README for command list with: ~README~"
  end
end
