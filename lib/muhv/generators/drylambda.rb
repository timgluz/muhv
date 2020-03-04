module Muhv
  module Generators
    # this generates Ruby lambdas using the Dry libraries and patterns
    class DryLambda < Thor::Group
      include Thor::Actions

      argument :name, desc: 'the name of new lambda project'

      class_option :deploy_framework, default: :serverless,
                   desc: 'which serverless framework to use (default: serverless)',
                   type: :string
      class_option :ruby_version,
                   default: '2.5.1',
                   desc: 'specify ruby-version used for the project',
                   type: :string

      def self.source_root
        File.expand_path("../../../..", __FILE__)
      end

      # set up ruby project
      def add_gemfile
        copy_file 'static/dry/Gemfile.default', "#{name}/Gemfile"
        say 'Add Gemfile', :green
      end

      def add_native_extension_gemfile
        if yes?('Add Gemfile for native extensions?')
          copy_file 'static/dry/Gemfile.exts', "#{name}/Gemfile.exts"
          say 'Add Gemfile for for native extensions'
        else
          say 'Ignoring Gemfile.exts'
        end
      end

      def create_readme
        template('templates/dry/readme.tt', "#{name}/README.md")
      end

      # set up lambda project
      def add_handlers
        template 'templates/dry/app.tt', "#{name}/app.rb"
      end

      def add_makefile
        template 'templates/dry/makefile.tt', "#{name}/Makefile"
      end

      # set up app folder
      def add_app_folder
        directory 'templates/dry/app', "#{name}/app", recursive: true
      end

      # set up config folders
      def add_config_folder
        directory 'templates/dry/config', "#{name}/config", recursive: true
      end

      # set up spec fodler
      def add_spec_folder
        directory 'templates/dry/spec', "#{name}/spec", recursive: true
      end

      # add serverless boilerplate
      def copy_deployment_script
        if options[:deploy_framework] == 'serverless'
          template 'templates/dry/serverless.tt', "#{name}/serverless.yml"
        end
      end
    end
  end
end
