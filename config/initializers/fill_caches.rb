# Fill caches on startup
unless Rails.env == 'test'
  puts "Filling caches..."
  Instance.new.all
end
