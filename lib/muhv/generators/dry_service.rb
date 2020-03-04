module Muhv
  module Generators
    # generates required boilerplate for Dry Service
    class DryService < Thor::Group
      include Thor::Actions

      argument :name, desc: 'service name'
      class_option :target_folder,
                   type: :string,
                   desc: 'fullpath to target folder'

      DEFAULT_TEMPLATE_VALUES = {
        with_rules: true
      }

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
        file_path = [target_folder, "#{name}_service.rb"].compact.join('/')

        template_values = {
          service_name: name
        }.merge(DEFAULT_TEMPLATE_VALUE)

        if yes?('Do you want to use validation without rules?')
          template_values[:with_rules] = false
        end

        template 'templates/dry_service/service.tt',
                 file_path,
                 context: template_values

        say "Add new service: #{file_path}", :green
      end
    end
  end
end
