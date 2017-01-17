# Garoon Cat: A ruby interface to the Garoon API

[![Gem Version](https://badge.fury.io/rb/garoon-cat.svg)](https://badge.fury.io/rb/garoon-cat)

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'garoon-cat'
```

or

```ruby
gem 'garoon-cat', git:'https://github.com/mh61503891/garoon-cat.git'
```

And then execute:

```bash
bundle install
```

Example Code 1: WS-Security Authentication

```ruby
require 'garoon-cat'

garoon = GaroonCat.setup({
  uri: ENV['URI'],
  username: ENV['USERNAME'],
  password: ENV['PASSWORD']
})

garoon.service(:base).get_user_versions()
```

Example Code 2: Cookie Authentication

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

@garoon = GaroonCat.setup({
  uri: ENV['URI'],
  username: ENV['USERNAME'],
  password: ENV['PASSWORD']
})
@base = @garoon.service(:base)

def write_json(filename, object)
  File.open(filename, 'wb') do |io|
    io.write(JSON.pretty_generate(object))
  end
end

def read_json(filename)
  File.open(filename) do |io|
      JSON.parse(io.read)
  end
end

# dump org_versions.json
write_json('org_versions.json', @base.get_organization_versions())

# dump orgs.json
org_ids = read_json('org_versions.json')['organization_item'].map{ |e| e['id'] }
write_json('orgs.json', @base.get_organizations_by_id(organization_id:org_ids))

# dump user_versions.json
write_json('user_versions.json', @base.get_user_versions())

# dump users.json
user_ids = read_json('user_versions.json')['user_item'].map{ |e| e['id'] }
write_json('users.json', @base.get_users_by_id(user_id:user_ids))
```

Execution:

```bash
$ ls -1
Gemfile
dump.rb

$ cat Gemfile
gem 'garoon-cat', git:'https://github.com/mh61503891/garoon-cat.git'

$ bundle install
Using concurrent-ruby 1.0.4
Using i18n 0.7.0
Using minitest 5.10.1
Using thread_safe 0.3.5
Using unf_ext 0.0.7.2
Using httpclient 2.8.3
Using xml-simple 1.1.5
Using bundler 1.13.7
Using tzinfo 1.2.2
Using unf 0.1.4
Using activesupport 5.0.1
Using domain_name 0.5.20161129
Using http-cookie 1.0.3
Using garoon-cat 0.1.0 from https://github.com/mh61503891/garoon-cat.git (at master@5140f80)
Bundle complete! 1 Gemfile dependency, 14 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

URI=https://example.net/cgi-bin/cbgrn/grn.cgi USERNAME=username PASSWORD=password bundle exec ruby dump.rb
```

Result:

```bash
$ cat orgs.json | head
{
  "organization": [
    {
      "key": "1",
      "name": "Tottori Daraz Company",
      "order": "1",
      "version": "0000000000",
      "organization": [
        {
          "key": "2", 
```

## Development

### Test

```bash
export URI=https://example.net/cgi-bin/cbgrn/grn.cgi
export USERNAME=username
export PASSWORD=password
```

```bash
bundle exec rake test
```

```bash
$ bundle exec ruby -Itest test/garoon-cat_test.rb
```

```bash
$ bundle exec ruby -Itest test/garoon-cat_test.rb --name test_users
```

```bash
$ bundle exec guard
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
