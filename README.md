# Capistrano::Puma

Capistrano integration tasks for the [puma web server](https://github.com/puma/puma).

These tasks assume that you are using the [jungle tool scripts](https://github.com/puma/puma/tree/master/tools/jungle).

This is an extension of the puma tasks from [Deploying a Rails app on Nginx/Puma with Capistrano](http://tommy.chheng.com/2013/01/23/deploying-a-rails-app-on-nginxpuma-with-capistrano) of [Tommy Chheng](https://github.com/tc).

[![Gem Version](https://badge.fury.io/rb/capistrano-puma.png)](http://badge.fury.io/rb/capistrano-puma)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-puma', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-puma

## Usage

Use it in your deploy.rb as:

```ruby
require 'capistrano/puma'
```

Please ensure, that you've set the `application` property to identify the application to manage, e.g.:

```ruby
set :application, 'foobar'

cap puma:start   # => /etc/init.d/puma start foobar
```

On inclusion the following capistrano callbacks are inserted:

```ruby
after "deploy:start",          "puma:start"
after "deploy:stop",           "puma:stop"
after "deploy:restart",        "puma:restart"
after "deploy:create_symlink", "puma:after_symlink"
```

Or you just call it by hand like:

    cap puma:status

## Available tasks

    cap puma:start      # Start puma instance
    cap puma:stop       # Stop puma instance
    cap puma:restart    # Restart puma instance
    cap puma:status     # Status of puma instance
    cap puma:overview   # Status of all puma instances

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
