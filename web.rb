require 'sinatra/base'

module SlackNumberman
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
