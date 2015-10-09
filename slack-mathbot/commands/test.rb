module SlackMathbot
  module Commands
    class Test < SlackRubyBot::Commands::Base
      operator ']'
      command 'test'

      def self.call(client, data, match)
          send_message client, data.channel, match
        result = Dentaku::Calculator.new.evaluate(match[:expression]) if match.names.include?('expression')
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
  end
end
