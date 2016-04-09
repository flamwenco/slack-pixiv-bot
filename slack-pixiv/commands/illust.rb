# coding: utf-8
module SlackMathbot
  module Commands
    class Illust < SlackRubyBot::Commands::Base
      match /member_illust\.php(?<url>.*)$/ do |client, _data, _match|

        # Initalize Mechanize
        agent = Mechanize.new

        # Create Pixiv URL
        # If a full URL is given, extra characters are appended for some reason.
        # This ensures we catch them better
        if (_data[:text].include? "pixiv.net")
          pixiv_url = "http://www.pixiv.net/member_illust.php" + _match[:url][0..-2]
        else
          pixiv_url = "http://www.pixiv.net/member_illust.php" + _match[:url][0..-1]
        end
        puts pixiv_url

        # Create iOS Illustration URL, regex pixiv_url to
	# extract numbers only, such as /^[0-9]+$/
        #ios_url = "pixiv://illusts/" + pixiv_url.split("illust_id=")[-1]
       	ios_url = "pixiv://illusts/" + pixiv_url[/\d+/]
	puts ios_url

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
              text: "<" + ios_url + "|Open in App>",
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
