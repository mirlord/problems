
# Problem testing framework

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'std_ext.rb'
require 'launchers.rb'
require 'context.rb'
require 'matchers.rb'
require 'problems.rb'

$LOAD_PATH.drop 1

