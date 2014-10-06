Cloud Dashboard
================

Custom dashboard for showing all of your active EC2 instances.

Getting Started
---------------
1. Install ruby 2.1.1
1. bundle install (Install bundler if you don't have it)
1. Create a config file to load aws creds `config/application.yml`

    ```shell
    # For AWS Client
    AWS_ACCESS_KEY_ID: 'your-key-goes-here'
    AWS_SECRET_ACCESS_KEY: 'your-secret-key-goes-here'
    AWS_REGION: 'us-east-1'
    ```
1. Create tmp directories

    ```shell
    rake tmp:create
    ```
1. Configure and seed database (Install sqlite if you don't have it via homebrew or apt)

    ```shell
    bundle exec rake db:migrate
    bundle exec rake db:seed
    ```
1. Start memcached in a separate window (Install it if you don't have it via homebrew or apt)

    ```shell
    memcached
    ```

1. Start rails

    ```shell
    bundle exec rails s
    ```

1. Visit site http://localhost:3000
1. Default login: user@example.com pass: changeme
1. Go to instances tab in top navigation bar

Caching
-------
Fetching the instances is cached on the start of the app and expires after 5 minutes.  If you want to flush the cache by hand
just stop and start memcached.

Running Tests
-------------
1. Run all specs

    ```shell
    bundle exec rake spec
    ```
1. Code coverage is generated at `coverage/index.html`
