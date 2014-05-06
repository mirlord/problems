
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
      if opts.is_a?(String)
        options = {:input => opts}
      elsif opts.is_a?(Array)
        options = {:input => opts.join("\n")}
      else
        options = opts
      end
      @cases << PCase.new(options, block)
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

