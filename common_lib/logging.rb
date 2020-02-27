# central point for test logging
# https://docs.ruby-lang.org/en/2.6.0/Logger.html

Dir.mkdir 'logs' unless File.exist? 'logs'
time = Time.now.strftime("%Y-%m-%d-%H꞉%M꞉%S")

log_file = File.open("logs/" + time + ".log", "a")

class MultiIO
  def initialize(*targets)
    @targets = targets
  end

  def write(*args)
    @targets.each {|t| t.write(*args)}
  end

  def close
    @targets.each(&:close)
  end
end

LOG = Logger.new MultiIO.new(STDOUT, log_file)
