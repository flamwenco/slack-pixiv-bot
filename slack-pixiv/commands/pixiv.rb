# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Commands::Base
      match /pixiv\.net(?<url>.*)$/ do |client, _data, _match|

        # Initalize Mechanize
        agent = Mechanize.new

        # Create Pixiv URL
        pixiv_url = "http://www.pixiv.net" + _match[:url][0..-2]
        puts pixiv_url

        # Scrape page title
        title = Mechanize.new.get(pixiv_url).title
        puts title

        # Scrape image
        image_url = agent.get(pixiv_url).images_with(:src => /600x600\/img-master/)[0].to_s.sub! '600x600','480x960'
        puts image_url

        client.web_client.chat_postMessage(
          channel: _data.channel,
          as_user: true,
          attachments: [
            {
              fallback: title + " - " + pixiv_url,
              title: title,
              title_link: pixiv_url,
              image_url: image_url,
              color: "#2684BD"
            }
          ].to_json
        )

      end
    end
  end
end
