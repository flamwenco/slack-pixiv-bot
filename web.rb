require 'sinatra/base'

module SlackPixiv
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
