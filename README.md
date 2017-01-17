# Garoon Cat: A ruby interface to the Garoon API

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'garoon-cat', git:'https://github.com/mh61503891/garoon-cat.git'
```

And then execute:

```bash
bundle install
```

Example Code 1: WS-Security

```ruby
require 'garoon-cat'
garoon = GaroonCat.setup({
  uri: ENV['URI'],
  username: ENV['USERNAME'],
  password: ENV['PASSWORD']
})
garoon.service(:base).get_user_versions()
```

Example Code 2: Cookie

```ruby
require 'garoon-cat'
garoon = GaroonCat.setup(uri:ENV['URI'])
garoon.service(:util).login({
  login_name: ENV['USERNAME'],
  password: ENV['PASSWORD']
})
garoon.service(:base).get_user_versions()
garoon.service(:util).logout
```

Example code 3: Dump information of organizations and users

```ruby
require 'garoon-cat'
require 'json'

garoon = GaroonCat.setup({
  uri: ENV['URI'],
  username: ENV['USERNAME'],
  password: ENV['PASSWORD']
})
base = garoon.service(:base)

# dump organization_versions
File.open('organization_versions.json', 'wb'){ |io| 
  io.write(JSON.pretty_generate(base.get_organization_versions()))
}

# dump organizations
organization_ids = JSON.parse(File.read('organization_versions.json'))['organization_item'].map{ |e| e['id'] }
File.open('organizations.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_organizations_by_id(organization_id:organization_ids))) }

# dump user_versions
File.open('user_versions.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_user_versions())) }

# dump users
user_ids = JSON.parse(File.read('user_versions.json'))['user_item'].map{ |e| e['id'] }
File.open('users.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_users_by_id(user_id:user_ids))) }



```


Execute:

```bash
URI=https://example.net/cgi-bin/cbgrn/grn.cgi USERNAME=username PASSWORD=password bundle exec ruby scripts.rb
```


## Development

### Test

```bash
$ bundle exec rake test
```

```bash
$ bundle exec ruby -Itest test/garoon-cat_test.rb
```

```bash
$ bundle exec guard
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
