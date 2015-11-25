$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slack-numberman'
require 'web'

Thread.new do
  begin
    SlackNumberman::App.instance.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run SlackNumberman::Web
