module Muhv
  module Generators
    # generates all required configs for linters and project config
    class RubyDotfiles < Thor::Group
      include Thor::Actions

      argument :name, desc: 'project name'
      argument :target_folder, type: :string, desc: 'fullpath to target'

      def self.source_root
        File.expand_path('../../../', __dir__)
      end

      def copy_gitignore
        copy_file 'static/dry/gitignore', "#{target_folder}/.gitignore"
        say 'Add .gitignore', :green
      end

      def copy_editorconfig
        copy_file 'static/dry/editorconfig', "#{target_folder}/.editorconfig"
        say 'Add .editorconfig', :green
      end

      def copy_rubocop
        copy_file 'static/dry/rubocop.yml', "#{target_folder}/.rubocop.yml"
        say 'Add .rubocop.yml', :green
      end

      def copy_overcommit
        copy_file 'static/dry/overcommit.yml', "#{target_folder}/.overcommit.yml"
        say 'Add .overcommit.yml', :green
      end

      def add_ruby_gemset_file
        create_file "#{name}/.ruby-gemset", name.to_s.downcase
        say 'Add .ruby-gemset', :green
      end

      def add_ruby_version_file
        create_file "#{name}/.ruby-version", options[:ruby_version].to_s
        say 'Add .ruby-version'
      end
    end
  end
end
