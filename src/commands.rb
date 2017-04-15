class Commands

  def filter_commands(event)
    command = event.content.to_s()
    command = clean_command(command)
    if command == "exit"
      shut_down_bot(event)
    elsif command == "readme"
      post_readme(event)
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
    event.respond readme
  end
end
