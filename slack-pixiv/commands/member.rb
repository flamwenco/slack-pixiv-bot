# coding: utf-8
module SlackMathbot
  module Commands
    class Member < SlackRubyBot::Commands::Base
      match /member\.php(?<url>.*)$/ do |client, _data, _match|

        # Initalize Mechanize
        agent = Mechanize.new

        pixiv_url = "http://www.pixiv.net/member.php" + _match[:url][0..-2]
        puts pixiv_url.split("?id=")[-1]

        # Scrape page title
        title = Mechanize.new.get(pixiv_url).title
        puts title

        # Scrape username
        username = Mechanize.new.get(pixiv_url).at(".name").text
        puts username

        # Scrape profile comment
        profile_comment = Mechanize.new.get(pixiv_url).at(".profile-comment").text.split("br { display : none;}")[-1]
        puts profile_comment

        # Scrape works count
        #works = Mechanize.new.get(pixiv_url).at(".count")
        works = agent.get(pixiv_url).links_with(:class => /int/)
        puts works

        # Create iOS Member URL, must find correct URL scheme
        ios_mem_url = "pixiv://users/" + pixiv_url.split("?id=")[-1]
        puts ios_mem_url

        client.web_client.chat_postMessage(
          channel: _data.channel,
          as_user: true,
          attachments: [
            {
              fallback: title + " - " + pixiv_url,
              text: "<" + ios_mem_url + "|Open in App>",
              text: profile_comment,
              title: username,
              title_link: pixiv_url,
              color: "#2684BD",
              fields: [
                {
                  title: "Works",
                  value: works[0].text,
                  short: true,
                },
                {
                  title: "Bookmarks",
                  value: works[1].text,
                  short: true,
                },
                {
                  title: "Follow",
                  value: works[2].text,
                  short: true,
                }
              ]
            }
          ].to_json
        )

      end
    end
  end
 end
