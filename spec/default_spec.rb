require 'spec_helper'

describe 'ldk-mongodb::default' do
  before do
    Fauxhai.mock(path: 'spec/fixtures/arch.json') do |node|
    end
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      set_attributes_for node
    end.converge(described_recipe)
  end

  it 'should install mongodb and related packages' do
    expect(chef_run).to install_package 'mongodb'
    expect(chef_run).to install_package 'mongodb-tools'
  end
end
