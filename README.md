# Sample plugin for Bridgetown

_NOTE: This isn't a real plugin! Copy this sample code and use it to create your own Ruby gem! [Help guide here…](https://www.bridgetownrb.com/docs/plugins)_ 😃

A Bridgetown plugin to [fill in the blank]…

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
$ bundle add my-awesome-plugin -g bridgetown_plugins
```

Or simply add this line to your Gemfile:

```ruby
gem 'my-awesome-plugin', group: "bridgetown_plugins"
```

## Usage

The plugin will…

### Optional configuration options

The plugin will automatically use any of the following metadata variables if they are present in your site's `_data/site_metadata.yml` file.

…

## Testing

* Run `bundle exec rspec` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and test with rspec together

## Contributing

1. Fork it (https://github.com/mygithub/my-awesome-plugin/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Releasing

To release a new version of the plugin, simply bump up the version number in both
`version.rb` and `package.json, and then run `script/release`.
