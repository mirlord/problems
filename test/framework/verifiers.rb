
module Problems

  module Verifiers

    def assert(cond)
      if cond
        puts 'OK'
      else
        puts 'FAIL'
      end
    end

    def exactly( expected )
      expected = expected.join(" ") if expected.is_a? Array
      assert @output.strip.eql?( expected.to_s.strip )
    end

  end

end

