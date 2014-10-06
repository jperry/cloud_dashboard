class Instance

  def initialize(options={})
    @gateway = options.fetch(:gateway) { AWS::Ec2InstanceGateway.new }
  end

  def all
    Rails.cache.fetch(:instances, expires_in: 5.minutes) do
      @gateway.instances
    end
  end
end
