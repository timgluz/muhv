require 'logger'
require 'forwardable'
require 'singleton'

class Log
  extend Forwardable
  include Singleton

  def initialize
    @logger ||= Logger.new(STDOUT)
    @error_logger ||= Logger.new(STDERR)
  end

  def self.method_missing(m, *args, &block)
    Log.instance.send(m, *args, &block)
  end

  def_delegators :@logger, :info, :info?, :debug, :debug?, :warn, :warn?, :unknown, :log
  def_delegators :@error_logger, :error, :error?, :fatal, :fatal?
end
