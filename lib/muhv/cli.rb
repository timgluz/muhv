require 'thor'
require 'muhv/generators'

module Muhv
  # this glass combines and calls sub generators
  class Cli < Thor
    check_unknown_options!

    desc 'version', 'Display MyGem version'
    map %w[-v --version] => :version

    def version
      say "Muhv v.#{Muhv::VERSION}"
    end

    def self.exit_on_failure?
      true
    end

    desc 'drylambda NAME', 'Creates a new Ruby lambda with Dry patterns'
    option :ruby_version, default: '2.5.1', aliases: '-rv'
    option :deploy_framework, default: 'serverless', aliases: '-df'
    def drylambda(name)
      path = File.expand_path(name)
      raise Error, "ERROR: #{path} already exists." if File.exist?(path)

      say "Creating new DryLambda project #{name}", :green
      generator = Muhv::Generators::DryLambda.new([name], options)
      generator.invoke_all

      say 'Add Ruby dotfiles', :green
      generator = Muhv::Generators::RubyDotfiles.new([name, path], options)
      generator.invoke_all

      say 'Done.', :green
    end

    desc 'rbdotfiles SUBFOLDER_NAME', 'generates Ruby dotfiles into the subfolder'
    def rbdotfiles(name)
      path = File.expand_path(name)
      raise Error, "ERROR: #{path} doesnt exists." unless File.exist?(path)

      say 'Add Ruby dotfiles', :green
      generator = Muhv::Generators::RubyDotfiles.new([name, path], options)
      generator.invoke_all

      say 'Done.', :green
    end

    desc 'service NAME', 'generates a new service into current folder'
    def service(name)
      if name.nil? || name.empty?
        raise Error, 'Error: the service name can not be empty'
      end

      service_name = name # check how we could convert it to Module
      say "Adding new service: #{service_name}", :green
      generator = Muhv::Generators::DryService.new([service_name], options)
      generator.invoke_all

      say 'Done.', :green
    end
  end
end
