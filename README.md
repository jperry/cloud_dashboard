Cloud Dashboard
================

Custom dashboard for showing all of your active EC2 instances.

Getting Started
---------------
# Install ruby 2.1.1
# bundle install (Install bundler if you don't have it)
# Create a config file to load aws creds `config/application.yml`
```
# For AWS Client
AWS_ACCESS_KEY_ID: 'your-key-goes-here'
AWS_SECRET_ACCESS_KEY: 'your-secret-key-goes-here'
AWS_REGION: 'us-east-1'
```
# Start memcached in a separate window
`memcached`
# Start rails
`bundle exec rails s
# Visit site http://localhost:3000
# Default login: user@example.com pass: changeme
# Go to instances tab in top navigation bar

Running Tests
-------------
# bundle exec rake spec
# Code coverae is generated at `coverage/index.html`


