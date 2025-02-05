require 'thor'
require 'muhv/generators'

module Muhv
  # this glass combines and calls sub generators
  class Cli < Thor
    DEFAULT_SERVICE_TARGET_PATH = 'app/services'.freeze
    DEFAULT_SERVICE_SPEC_PATH = 'spec/services'.freeze
    DEFAULT_SERVICE_FILE_EXT = 'rb'.freeze

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
    option :target_path,
           type: :string,
           desc: 'fullpath to target folder',
           default: DEFAULT_SERVICE_TARGET_PATH

    option :spec_path,
           type: :string,
           desc: 'path to spec folder, default spec/services',
           default: DEFAULT_SERVICE_SPEC_PATH

    option :file_ext,
           type: :string,
           desc: 'file extensions for the generated file, default: rb',
           default: DEFAULT_SERVICE_FILE_EXT

    option :with_rules,
           type: :boolean,
           desc: 'if true it would use validator with rules, otherwise basic schema',
           default: true

    option :with_prefix,
           type: :boolean,
           desc: 'add Service prefix to the class name if true',
           default: true

    option :with_spec_prefix,
           type: :boolean,
           desc: 'set false if you dont want to have spec in test file',
           default: true
    def service(name)
      if name.nil? || name.empty?
        raise Error, 'Error: the service name can not be empty'
      end

      generator = Muhv::Generators::DryService.new([name], options)
      generator.invoke_all

      say 'Done.', :green
    end
  end
end
