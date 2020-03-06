module Muhv
  module Generators
    # generates required boilerplate for Dry Service
    class DryService < Thor::Group
      include Thor::Actions

      argument :name, desc: 'filename of the service'
      def self.source_root
        File.expand_path('../../../', __dir__)
      end

      def generate_service
        file_name = build_file_name(
          name, prefix: 'service', with_prefix: options[:with_prefix]
        )
        file_ext = options[:file_ext]
        target_folder = options[:target_path]

        file_path = join_as_path(target_folder, "#{file_name}.#{file_ext}")
        @service_name = inflect_service_name(file_name)
        @with_rules = options.fetch(:with_rules, true)

        template 'templates/dry_service/dry_service.tt', file_path

        say "Add new service: #{file_path}", :green
      end

      def generate_spec
        file_name = build_file_name(
          name, prefix: 'service', with_prefix: options[:with_prefix]
        )
        spec_file_name = build_file_name(
          name, prefix: 'service_spec', with_prefix: options[:with_prefix]
        )
        spec_path = options[:spec_path]
        file_ext = options[:file_ext]
        file_path = join_as_path(spec_path, "#{spec_file_name}.#{file_ext}")

        @service_name = inflect_service_name(file_name)
        @with_rules = options.fetch(:with_rules, true)
        template 'templates/dry_service/dry_service_spec.tt', file_path

        say "Add new spec: #{file_path}", :green
      end

      private

      def build_file_name(name, prefix: nil, with_prefix: true)
        file_name = name.to_s.strip
        prefix = prefix.to_s.strip.downcase

        if with_prefix && prefix.size > 0
          file_name += '_' + prefix
        end

        file_name
      end

      # TODO: check lib from std-lib that would work also on windows
      def join_as_path(*items, separator: '/')
        items.compact.join(separator)
      end

      def inflect_service_name(file_name)
        Dry::Inflector.new.camelize(file_name)
      end
    end
  end
end
