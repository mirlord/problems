
module Problems

  class PResult

    include Problems::Matchers

    def initialize(str)
      @output = str
    end

    def verify(block)
      instance_exec(&block)
    end

    def assert(cond)
      if cond
        puts 'OK'
      else
        puts 'FAIL'
      end
    end

    def matches(expectations)

      expectations = [expectations] if ! expectations.is_a? Array
      matches = true
      expectations.zip(@output.strip.split("\n")).each do |e, v|
        e = exactly(e) unless e.is_a? Problems::Matchers::Matcher
        matches = matches && e.matches(v)
        if (!matches)
          puts "Expected: #{e.to_s}, found: <#{v}>"
        end
      end
      assert matches
    end

  end

  class Problem

    attr_reader :name, :cases

    def initialize(name, block)
      @name = name
      @cases = []
      instance_exec(&block)
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
  p = Problems::Problem.new(name, block)
  CTX.put(p)
end

