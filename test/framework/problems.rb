
module Problems

  class PResult

    include Problems::Verifiers

    def initialize(str)
      @output = str
    end

  end

  class Problem

    attr_reader :name, :cases

    def initialize(name)
      @name = name
      @cases = []
    end

    def on(opts, &block)
      @cases << PCase.new(opts, block)
    end

  end

  class PCase

    attr_reader :options, :assertion

    def initialize(opts, block)
      @options = opts
      @assertion = block
    end

  end

end

def problem(name, &block)
  p = Problems::Problem.new(name)
  CTX.put(p)
  block.yield p
end

