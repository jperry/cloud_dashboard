class Instance
  def initialize(options={})
    @gateway = options.fetch(:gateway) { AWS::Ec2InstanceGateway.new }
  end

  def all
    @gateway.instances
  end
end
