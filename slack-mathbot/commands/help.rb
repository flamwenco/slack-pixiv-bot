module SlackMathbot
  module Commands
    class Help < SlackRubyBot::Commands::Base
      def self.call(client, data, _match)
        send_message client, data.channel, 'See https://github.com/dblock/slack-mathbot, please.'
      end
    end
  end
end
