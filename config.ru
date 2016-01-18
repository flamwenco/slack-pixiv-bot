$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slack-pixiv'
require 'web'

Thread.new do
  begin
    SlackPixiv::App.instance.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run SlackPixiv::Web
