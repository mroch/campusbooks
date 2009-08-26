require 'rubygems'
require 'test/unit'
begin
  require 'shoulda'
rescue LoadError
  puts "Shoulda not available. Install it with: sudo gem install thoughtbot-shoulda -s http://gems.github.com"
end
begin
  require 'mocha'
rescue LoadError
  puts "Mocha not available. Install it with: sudo gem install mocha"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'campusbooks'

class Test::Unit::TestCase
end
