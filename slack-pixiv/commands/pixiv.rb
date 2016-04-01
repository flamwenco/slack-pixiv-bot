# coding: utf-8
module SlackMathbot
  module Commands
    class Pixiv < SlackRubyBot::Commands::Base
      match /pixiv\.net(?<url>.*)$/ do |client, _data, _match|

        # Initalize Mechanize
        agent = Mechanize.new

        # Get time
        time = Time.now

        # Create Pixiv URL
        pixiv_url = "http://www.pixiv.net" + _match[:url][0..-2]
        puts pixiv_url

        # Create iOS Illustration URL, regex pixiv_url to
	# extract numbers only, such as /^[0-9]+$/
        #ios_url = "pixiv://illusts/" + pixiv_url.split("illust_id=")[-1]
       	ios_url = "pixiv://illusts/" + pixiv_url[/\d+/]
	puts ios_url


	# TODO: Create iOS Member URL, must find correct URL scheme
	ios_mem_url = "pixiv://member/" + pixiv_url.split("?id=")[-1]
	puts ios_mem_url

        # Scrape page title
        title = Mechanize.new.get(pixiv_url).title
        puts title

        # Scrape image
        r = Range.new(
          Time.local(time.year, time.month, time.day, 12),
          Time.local(time.year, time.month, time.day, 20)
        ) === time

        if ((Date.today.to_s == "2016-04-01") && (r))
          api_url = "http://rule34.paheal.net/api/danbooru/find_posts/index.xml"

          agent.get(api_url)
          xml = agent.current_page.body
          status = XmlSimple.xml_in(xml)
          image_url = status["post"].sample["file_url"]
          puts agent.get(pixiv_url).images_with(:src => /600x600\/img-master/)[0].to_s.sub! '600x600','480x960'
        else
          image_url = agent.get(pixiv_url).images_with(:src => /600x600\/img-master/)[0].to_s.sub! '600x600','480x960'
          puts image_url
        end

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
