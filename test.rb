#!/usr/bin/env ruby

require 'rake/file_list'

require './test/framework/test_framework.rb'

TEST_FILES = Rake::FileList['./test/*_test.rb']
TEST_FILES.each { |f|
  require f
}

def main
  pname, lang = ARGV[0].split(':')
  lang = :all if lang.nil?
  CTX.run(pname.to_sym, lang.to_sym)
end

if ARGV.empty?
  puts "Usage:\n\n"

  puts "#{$0} <problem>[:<lang>]\n\n"

  puts "Examples:\n\n"
  puts "#{$0} all"
  puts "#{$0} all:all (the same as a previous example)"
  puts "#{$0} all:cc"
  puts "#{$0} backpack:all"
  puts "#{$0} backpack:java"
  exit 1
end

main

