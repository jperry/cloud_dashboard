describe AWS::Ec2InstanceGateway do
  before(:each) { @gateway = AWS::Ec2InstanceGateway.new }

  describe '#instances', :vcr do
    it 'should return a list of ec2 instance objects' do
      # Only grabbing 5 for testing purposes
      results = @gateway.instances(max_results: 5)
      expect(results[0][:name]).to eq('topperharley-mongodb-production-r02.jam')
      expect(results[0][:id]).to eq('i-8725d5a8')
      expect(results[0][:type]).to eq('m1.large')
      expect(results[0][:state]).to eq('running')
      expect(results[0][:availability_zone]).to eq('us-east-1b')
      expect(results[0][:public_ip]).to eq('54.226.162.137')
      expect(results[0][:private_ip]).to eq('10.124.197.226')
    end

    it 'should return an empty set if no results are returned' do
      # Force an empty set by sending a bogus filter to match
      expect(@gateway.instances(filters: [{ name: 'instance-id', values: ['empty_results']}]).size).to eq(0)
    end
  end
end
