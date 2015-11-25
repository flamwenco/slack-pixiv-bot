require 'slack-ruby-bot'
require 'wolfram'

module NumberManBot
  class App < SlackRubyBot::App
      operator '='
      command 'calculate'
      def self.call(client, data, match)
        puts match[:expression]
        result = Dentaku::Calculator.new.evaluate(match[:expression])
		#if match.names.include?('expression')
        result = result.to_s if result
        if result && result.length > 0
          send_message client, data.channel, result
        else
          send_message client, data.channel, 'Got nothing.'
        end
      rescue StandardError => e
        send_message client, data.channel, "Sorry, #{e.message}."
      end
  end

  class Ping < SlackRubyBot::Commands::Base
    def self.call(client, data, _match)
      client.message text: 'pong', channel: data.channel
    end
  end
end

NumberManBot::App.instance.run
