module AWS
  class Ec2InstanceGateway

    def initialize(options={})
      @client = options.fetch(:client) { Aws::EC2::Client.new }
    end

    def instances(options={})
      options = default_options.merge(options)
      @client.describe_instances(options).reservations.map do |r|
        instance = r.instances[0]
        name = ""
        instance.tags.each do |t|
          name = t.value if t.key == 'Name'
        end
        {
          name: name,
          id: instance.instance_id,
          type: instance.instance_type,
          state: instance.state.name,
          availability_zone: instance.placement.availability_zone,
          public_ip: instance.public_ip_address || '',
          private_ip: instance.private_ip_address || ''
        }
      end
    end

    def default_options
      {
        filters: [
                   {
                     name: 'instance-state-name',
                     values: %w(pending running shutting-down stopping stopped)
                   }
                 ]
      }
    end
  end
end
