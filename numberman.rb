require 'slack-ruby-bot'
require 'wolfram'

module NumberManBot
  class App < SlackRubyBot::App
  end

  class Weather < SlackRubyBot::Commands::Base
    match(/^How is the weather in (?<location>\w*)\?$/i) do |client, data, match|
      send_message client, data.channel, "The weather in #{match[:location]} is nice."
    end
  end

  class Calculator < SlackRubyBot::Commands::Base
  operator '=' do |client, _data, _match|
    # implementation detail
	Wolfram.appid = "R3KHQ2-2T2769PP4P"

	eq = _match[1..-1]
	result = Wolfram.fetch(eq[1])
	# to see the result as a hash of pods and assumptions:
	hash = Wolfram::HashPresenter.new(result).to_hash
	puts hash

	pods = hash[:pods]
	result = pods["Result"]
	#solution = pods["Real solutions"]
	puts result

	if result != nil
		result[0].sub! "~~", "≈"
    	send_message client, _data.channel, result[0]
	else
		solution = pods["Real solution"]
		puts solution
		if solution != nil
			solution[0].sub! "~~", "≈"
    		send_message client, _data.channel, solution[0]
		else
			solution = pods["Real solutions"]
			solution[0].sub! "~~", "≈"
			puts solution
    		send_message client, _data.channel, solution[0]
		end
	end
  end
  end
end

NumberManBot::App.instance.run
