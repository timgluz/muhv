require 'zeitwerk'

# load code
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

require 'muhv/version'
require 'muhv/generators'
require 'muhv/cli'

module Muhv
  class Error < StandardError; end
  # Your code goes here...
end
