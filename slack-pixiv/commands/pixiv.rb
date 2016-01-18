# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Commands::Base
      match /pixiv\.net(?<url>.*)\?$/ do |client, _data, _match|

        #asdf
        client.say(channel: data.channel, text: "Testing: #{match[:url]}")

      end
    end
  end
end
