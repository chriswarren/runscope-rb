# Runscope

Start using Runscope in just a couple lines of code for any request being made using Net::HTTP.

Currently supports Net::HTTP only - requests made using other libraries like libcurl or sockets won't work yet. If you want to add support for another library that would be fantastic.

## Installation

Add this line to your application's Gemfile:

    gem 'runscope', '~> 0.0.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install runscope

## Usage

  Runscope.configure do |config|
    config.bucket  = Rails.configuration.runscope.bucket
    config.domains = ["api.stackexchange.com", "api.github.com", /\S+\.desk\.com/]
  end

## Options

There are a few options that can be set:

`bucket` *Required*

A string for the bucket key from Runscope. Default is `nil`.

`domains` *Required*

An array of strings and regular expressions to match outbound traffic against. Any requests through Net::HTTP that don't match one of these will pass through unaltered. Default is `[]`.

`enabled`

A boolean to control if Runscope is used at all. Set to `false` to stop using Runscope. Default is `true`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
