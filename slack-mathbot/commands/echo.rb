module SlackMathbot
  module Commands
    class Echo < SlackRubyBot::Commands::Base
      command 'echo'

      def self.call(client, data, match)
        send_message client, data.channel, match[:expression]
      rescue StandardError => e
        send_message client, data.channel, "Sorry, #{e.message}."
      end
    end
  end
end
