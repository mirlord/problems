
module Problems

  class Context

    PROBLEMS = {}

    def run(name, lang)
      problem = PROBLEMS[name]
      if (lang.eql? :all)
        puts ':all is not supported yet, falling back to :java'
        lang = :java
      end
      launcher = Problems::Launchers::LAUNCHERS[lang]
      problem.cases.each do |tc|
        # obtain raw string output
        out = launcher.run(name, tc.options)
        # construct verifiable result
        r = PResult.new(out)
        tc.assertion.yield r
      end
    end

    def put(p)
      PROBLEMS[p.name.to_sym] = p
    end

  end
end

# Global single instance
CTX = Problems::Context.new

