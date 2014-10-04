require 'rails_helper'

RSpec.describe Instance, :type => :model do

  subject { described_class }

  describe '#new' do
    it 'should create an instance of Instances' do
      subject.new
    end
  end

  describe '.all' do
    it 'should call instances on the gateway object' do
      gateway = double()
      expect(gateway).to receive(:instances)
      subject.new(gateway: gateway).all
    end
  end
end
