module SlackMathbot
  module Commands
    class Calculator < SlackRubyBot::Commands::Base
      operator '=' do |client, _data, _match|
        # Set API key (donut steal)
        Wolfram.appid = "R3KHQ2-2T2769PP4P"
  
		# Get equation part of argument
        eq = _match[1..-1]
		
		# Get results from Wolfram Alpha
        result = Wolfram.fetch(eq[1])

        # Get hash of results
        hash = Wolfram::HashPresenter.new(result).to_hash

		# Debug output hash
        puts hash
      
		# Breakdown hash
        pods = hash[:pods]

		# Try for results
        result = pods["Result"]
        puts result
  
		# If result exists
        if result != nil
		  # Prettify equivalency
          result[0].sub! "~~", "≈"
            send_message client, _data.channel, result[0]
        else
		  # If result doesn't exist, look for the real solution
          solution = pods["Real solution"]
          puts solution

		  # If the real solution exists
          if solution != nil
		    # Prettify equivalency
            solution[0].sub! "~~", "≈"
            send_message client, _data.channel, solution[0]
          else
			# Check the other possible name for real solutions
            solution = pods["Real solutions"]

			if solution != nil
		      # Prettify equivalency
              solution[0].sub! "~~", "≈"
              puts solution
              send_message client, _data.channel, solution[0]
			else
			  decimal = pods["Decimal approximation"]

			  if decimal != nil
			    puts decimal
			    send_message client, _data.channel, decimal[0]
			  end
			end
          end
        end
      end
    end
  end
end
