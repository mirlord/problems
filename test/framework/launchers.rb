require 'open3'

module Problems

  module Launchers

    class BaseLauncher
      def exec(cmd, input)
        output, _ = Open3.capture2(cmd, :stdin_data => input)
        return output
      end

      def get_args(opts)
        return %{"#{opts[:args].join('" "')}"}
      end
    end

    class JavaLauncher < BaseLauncher
      def run(problem_name, options)
        pclass = problem_name.to_s.camelize # problem class name
        # compile
        `mkdir -p java/build/classes`
        `javac java/src/problems/#{pclass}.java -d java/build/classes`
        # run
        return exec("java -cp java/build/classes problems.#{pclass} #{get_args(options)}",
                    options[:input])
      end
    end

    class CCLauncher < BaseLauncher
      def run(problem_name, options)
        # compile
        `gcc -lm cc/#{problem_name}.c -o cc/a.out`
        # run
        return exec("cc/a.out #{get_args(options)}",
                    options[:input])
      end
    end

    class ErlangLauncher < BaseLauncher
      def run(problem_name, options)
        return exec("escript erlang/src/#{problem_name}.erl #{get_args(options)}",
                    options[:input])
      end
    end

    LAUNCHERS = {
      :java => JavaLauncher.new,
      :erlang => ErlangLauncher.new,
      :cc => CCLauncher.new,
    }

  end
end

