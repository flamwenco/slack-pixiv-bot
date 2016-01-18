# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Bot
      match /pixiv\.net(?<url>.*)$/ do |client, _data, _match|

        #asdf
        client.say(channel: _data.channel, text: "Testing: http://pixiv.net#{_match[:url]}")
        #send_message client, _data.channel, "Testing: #{_match[:url]}"

      end
    end
  end
end
