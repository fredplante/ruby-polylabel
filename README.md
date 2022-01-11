# Ruby-Polylabel

This is a ruby port of Mapbox's polylabel algorithm.

- Original repo: https://github.com/mapbox/polylabel
- Blog post: https://www.mapbox.com/blog/polygon-center/

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ruby-polylabel"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-polylabel

## Usage

```ruby
require "polylabel"

Polylabel.compute([[[0, 0], [1, 0], [2, 0], [0, 0]]]) # => {:x=>0, :y=>0, :distance=>0}

Polylabel.compute([[[0, 0], [1, 0], [1, 1], [0, 1], [0, 0]]]) # => {:x=>0.5, :y=>0.5, :distance=>0.5}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fredplante/ruby-polylabel.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
