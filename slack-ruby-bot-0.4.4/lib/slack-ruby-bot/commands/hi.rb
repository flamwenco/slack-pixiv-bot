module SlackRubyBot
  module Commands
    class Hi < Base
      def self.call(client, data, _match)
        send_message client, data.channel, "Hi <@#{data.user}>!"
      end
    end
  end
end
