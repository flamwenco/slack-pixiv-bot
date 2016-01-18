# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Commands::Base
      match /pixiv\.net(?<url>.*)$/ do |client, _data, _match|

        #asdf
        puts _match[:url]
        #client.say(channel: _data.channel, text: "Testing: http://pixiv.net#{_match[:url]}")
        client.web_client.chat_postMessage(
          channel: _data.channel,
          as_user: true,
          attachments: [
            {
              fallback: "Ticket #1943: Can't rest my password - https://groove.hq/path/to/ticket/1943",
              title: "Ticket #1943: Can't reset my password",
              title_link: "http://www.pixiv.net" + _match[:url][1..-1],
              text: "Help! I tried to reset my password but nothing happened!",
              color: "#7CD197"
            }
          ].to_json
        )
        #send_message client, _data.channel, "Testing: #{_match[:url]}"

      end
    end
  end
end
