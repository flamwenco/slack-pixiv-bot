# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Commands::Base
      match /pixiv\.net(?<url>.*)$/ do |client, _data, _match|

        #asdf
        puts _match[:url]
        #client.say(channel: _data.channel, text: "Testing: http://pixiv.net#{_match[:url]}")
        client.say(channel: _data.channel, attachments: "[{'pretext': 'pre-hello', 'text': 'text-world'}]")
        #send_message client, _data.channel, "Testing: #{_match[:url]}"

      end
    end
  end
end
