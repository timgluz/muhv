require 'spec_helper'

RSpec.describe Muhv::Generators::DryService, type: :service do
  def runner(name: 'test', **options)
    capture(:stdout) do
      Muhv::Generators::DryService.new([name], options).invoke_all
    end
  end

  let(:default_options) do
    {
      with_rules: true,
      with_prefix: true,
      target_path: 'tmp/output',
      spec_path: 'tmp/output',
      file_ext: 'rb'
    }
  end

  def clean_files(*file_paths)
    file_paths.to_a.each do |file_path|
      File.delete(file_path) if File.exist?(file_path)
    end
  end

  context 'default configs' do
    let(:test_service_path) { 'tmp/output/test_service.rb' }
    let(:test_spec_path) { 'tmp/output/test_service_spec.rb' }

    before do
      clean_files(test_service_path, test_spec_path)

      runner(**default_options)
    end

    after do
      clean_files(test_service_path, test_spec_path)
    end

    it 'outputs success to cli' do
      res = runner(**default_options)

      expect(res).to match(/Add new service: tmp\/output\/test_service.rb/i)
    end

    it 'generates service with expected content' do
      content = File.open(test_service_path).read

      expect(content).to match(/class TestService \< BaseDryService/)
      expect(content).to match(/BaseValidator/)
    end

    it 'generates a spec for the service' do
      content = File.open(test_spec_path).read

      expect(content).to match(/RSpec.describe TestService/)
    end
  end

  context 'service with module namespace' do
    let(:test_service_path) { 'tmp/output/services/test1_service.rb' }
    let(:test_spec_path) { 'tmp/output/services/test1_service_spec.rb' }

    before do
      clean_files(test_service_path, test_spec_path)

      runner(name: 'services/test1', **default_options)
    end

    after do
      clean_files(test_service_path, test_spec_path)
    end

    it 'generates expected files' do
      expect(File.exist?(test_service_path)).to be_truthy
      expect(File.exist?(test_spec_path)).to be_truthy
    end

    it 'generates service with namespace' do
      content = File.open(test_service_path).read

      expect(content).to match(/class Services::Test1Service \< BaseDryService/)
      expect(content).to match(/BaseValidator/)
    end

    it 'generates spec with namespace' do
      content = File.open(test_spec_path).read

      expect(content).to match(/RSpec\.describe Services::Test1Service/)
    end
  end

  context 'without service prefix' do
    let(:test_service_path) { 'tmp/output/test2.rb' }
    let(:test_spec_path) { 'tmp/output/test2_spec.rb' }

    before do
      clean_files(test_service_path, test_spec_path)
      runner_options = default_options.dup
      runner_options[:with_prefix] = false
      runner(name: 'test2', **runner_options)
    end

    after do
      clean_files(test_service_path, test_spec_path)
    end

    it 'generates expected files' do
      expect(File.exist?(test_service_path)).to be_truthy
      expect(File.exist?(test_spec_path)).to be_truthy
    end

    it 'generates service without prefix' do
      content = File.open(test_service_path).read

      expect(content).to match(/class Test2 \< BaseDryService/)
      expect(content).to match(/BaseValidator/)
    end

    it 'generates spec without prefix' do
      content = File.open(test_spec_path).read

      expect(content).to match(/RSpec\.describe Test2/)
    end
  end
end
