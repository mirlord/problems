
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

    def on(args = [], opts, &block)

      if opts.is_a? Hash
        options = opts
      elsif opts.is_a? Array
        options = {:input => opts.join("\n")}
      else # String, Number, etc
        options = {:input => opts.to_s}
      end
      options[:args] = [] if ! options.has_key? :args

      args = [args] if ! args.is_a? Array # String, Number, etc
      options[:args] = [ options[:args] ] if ! options[:args].is_a? Array
      options[:args] = args + options[:args]

      @cases << PCase.new(options, block)
    end

  end

  class PCase

    attr_reader :options, :assertion

    def initialize(options, block)
      @options = options
      @assertion = block
    end

    def self.method_missing(method_sym, *arguments, &block)
      @options[method_sym]
    end
  end

end

def problem(name, &block)
  p = Problems::Problem.new(name)
  CTX.put(p)
  block.yield p
end

