module Muhv
  module Generators
    # generates required boilerplate for Dry Service
    class DryService < Thor::Group
      include Thor::Actions

      DEFAULT_TEMPLATE_VALUES = {
        with_rules: true
      }

      DEFAULT_TARGET_PATH = 'app/services'
      DEAULT_FILE_EXT = 'rb'

      argument :name, desc: 'filename of the service'
      option :target_folder,
             type: :string,
             desc: 'fullpath to target folder',
             default: DEFAULT_TARGET_FOLDER

      option :file_ext,
             type: :string,
             desc: 'file extensions for the generated file, default: rb',
             default: DEFAULT_FILE_EXT

      def self.source_root
        File.expand_path('../../../', __dir__)
      end

      def add_parent_class
        if yes?('Does project already has BaseDryService class?')
          copy_file 'static/dry_service/base_dry_service.rb'
          say 'Add BaseDryService', :green
        else
          say 'Ignoring BaseDryService'
        end
      end

      def generate_class
        file_name = "#{name}_service"
        file_ext = options[:file_ext]
        file_path = [target_folder, "#{file_name}.#{file_ext}"].compact.join('/')
        service_name = inflect_service_name(file_name)

        template_values = {
          service_name: service_name
        }.merge(DEFAULT_TEMPLATE_VALUE)

        if yes?('Do you want to use validation without rules?')
          template_values[:with_rules] = false
        end

        template 'templates/dry_service/service.tt',
                 file_path,
                 context: template_values

        say "Add new service: #{file_path}", :green
      end

      private

      def inflect_service_name(file_name)
        Dry::Inflector.new.camelize(file_name)
      end

      def target_folder
        options.fetch(:target_folder) { DEFAULT_TARGET_PATH }
      end
    end
  end
end
