module AWS
  class Ec2InstanceGateway

    def initialize(opts={})
      @client = opts.fetch(:client) { Aws::EC2::Client.new }
    end

    def instances(options={})
      instances = []
      @client.describe_instances(options).reservations.each do |r|
        r.instances.each do |i|
          instances << i
        end
      end
      instances
    end
  end
end
