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

  context 'default configs' do
    it 'generates service' do
      res = runner(**default_options)
      p res
    end
  end
end
