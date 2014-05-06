
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
      assert @output.strip.eql?( expected.strip )
    end

  end

end

