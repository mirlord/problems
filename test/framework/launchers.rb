module Problems

  module Launchers

    class BaseLauncher
      def exec(cmd, input)
        IO.popen(cmd, 'r+') do |io|
          io.write( input ) if input
          return io.read
        end
      end
    end

    class JavaLauncher < BaseLauncher
      def run(problem_name, options)
        pclass = problem_name.to_s.camelize # problem class name
        # compile
        `mkdir -p java/build/classes`
        `javac java/src/problems/#{pclass}.java -d java/build/classes`
        # run
        return exec("java -cp java/build/classes problems.#{pclass} #{options[:args]}",
                    options[:input])
      end
    end

    LAUNCHERS = {
      :java => JavaLauncher.new,
    }

  end
end

