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
    nickname_file = File.open("data/nicknames.csv", 'w+')
    nickname_file << "#{card_name}~#{nickname}"
    nickname_file.close()
  end

  def unknown_command(event)
    event.respond "This command is unknown. Please see the README for command list with: ~README~"
  end
end
