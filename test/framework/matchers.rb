
module Problems

  module Matchers

    class Matcher

      def initialize(expectation)
        @expectation = expectation
      end

      def matches(value)
        false
      end
    end

    class AnyMatcher < Matcher

      def matches(value)
        value = value.strip
        @expectation.each do |e|
          return true if value.eql? e.to_s.strip
        end
      end

      def to_s
        "any(#{@expectation.to_s})"
      end

    end

    class PermMatcher < Matcher
    end

    class ExactMatcher < Matcher

      def matches(value)
        value.strip.eql?( @expectation.to_s.strip )
      end

      def to_s
        "[" + self.class.to_s + "] <" + @expectation.to_s + ">"
      end

    end

    def exactly(expectations)
      expectations = expectations.join(" ") if expectations.is_a? Array
      ExactMatcher.new expectations
    end

    def any(*expectations)
      AnyMatcher.new expectations
    end

  end

end

