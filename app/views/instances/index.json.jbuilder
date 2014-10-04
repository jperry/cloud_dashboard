json.array!(@instances) do |instance|
  json.extract! instance, :id
  json.url instance_url(instance, format: :json)
end
