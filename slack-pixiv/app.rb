module SlackPixiv
  class App < SlackRubyBot::App
    SlackRubyBot::Client.logger.level = Logger::WARN
  end
end
