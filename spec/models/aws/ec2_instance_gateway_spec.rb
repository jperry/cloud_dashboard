describe AWS::Ec2InstanceGateway do
  before(:each) { @gateway = AWS::Ec2InstanceGateway.new }

  describe '#instances', :vcr do
    it 'should return a list of ec2 instance objects' do
      # Only grabbing 5 for testing purposes
      results = @gateway.instances(max_results: 5)
      expect(results.size).to eq(5)
      expect(results.first.instance_id).to match(/i-[a-z0-9]{8}/)
    end

    it 'should return an empty set if no results are returned' do
      # Force an empty set by sending a bogus filter to match
      expect(@gateway.instances(filters: [{ name: 'instance-id', values: ['empty_results']}]).size).to eq(0)
    end
  end
end
