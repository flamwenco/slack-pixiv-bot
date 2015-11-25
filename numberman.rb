require 'slack-ruby-bot'
require 'wolfram'

module NumberManBot
  class App < SlackRubyBot::App
  end

  class Ping < SlackRubyBot::Commands::Base
    def self.call(client, data, _match)
      client.message text: 'pong', channel: data.channel
    end
  end

  class Weather < SlackRubyBot::Commands::Base
    match(/^How is the weather in (?<location>\w*)\?$/i) do |client, data, match|
      send_message client, data.channel, "The weather in #{match[:location]} is nice."
    end
  end

  class Calculator < SlackRubyBot::Commands::Base
  operator '=' do |_data, _match|
    # implementation detail
    send_message client, data.channel, "The weather in the net is nice."
  end
  end
end

NumberManBot::App.instance.run
