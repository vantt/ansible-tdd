module Serverspec::Type
  class ATDDRedis < Base
    def stdout
      command_result.stdout
    end

    def stderr
      command_result.stderr
    end

    def exit_status
      command_result.exit_status.to_i
    end

    private
    def command_result()
      @command_result ||= @runner.run_command("/ansible-tdd/redis-cli "+ @name)
    end

  end
  def redis(paths)
    ATDDRedis.new(paths)
  end
end

include Serverspec::Type