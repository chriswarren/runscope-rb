# runscope-rb

A gem to quickly get up and running with Runscope in a few lines of code.

runscope-rb currently supports Net::HTTP requests. Requests made using other HTTP libraries, such as libcurl or sockets, won't be modified. If you want to add support for another HTTP library that would be fantastic. See the section on Contributing at the end of the readme.

## Installation

Add this line to your application's Gemfile:

  gem 'runscope', '~> 0.0.2'

And then execute:

  $ bundle

Or install it yourself as:

  $ gem install runscope

## Usage

Obviously you'll need a [Runscope][http://runscope.com] account to use this. Then just run the configure block below within your code. If you're making a Rails app you probably want to put it in config/initializers/runscope.rb.

    Runscope.configure do |config|
      config.bucket  = "abcd1234"
      config.domains = ["api.stackexchange.com", "api.github.com", /\S+\.desk\.com/]
    end

## Options

There are a few options to set:

`bucket` *Required*

A string for the bucket key from Runscope. Default is `nil`.

`domains` *Required*

An array of strings and regular expressions to match outbound traffic against. Any requests through Net::HTTP that don't match one of these will pass through unaltered. Default is `[]`.

`enabled`

A boolean to control if Runscope is used at all. Set to `false` to stop using Runscope. Default is `true`.

## Troubleshooting

If your requests aren't being sent through Runscope after you're set up, check how the request is being made. If it's not using Net::HTTP it won't work at this time. Check the section below on Contributing if you want to add support.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
