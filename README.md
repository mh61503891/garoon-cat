# Garoon Cat

* This is a gem for Garoon API.
* This gem is **under construction now**.

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'garoon-cat', git:'https://github.com/mh61503891/garoon-cat.git'
```

And then execute:

```bash
bundle install
```

Create sample.rb:

```ruby
require 'garoon-cat'

params = {
  endpoint:ENV['ENDPOINT'],
  username:ENV['USERNAME'],
  password:ENV['PASSWORD']
}

base = GaroonCat::Service.new(params.merge({prefix:'cbpapi', name:'base' }))
p base.get_application_status()
```

Run sample.rb:

```bash
ENDPOINT=https://example.net/cgi-bin/cbgrn/grn.cgi USERNAME=username PASSWORD=password bundle exec ruby sample.rb
```

Output:

> {"application"=>[{"code"=>"portal", "status"=>"active"}, {"code"=>"space", "status"=>"deactive"}, {"code"=>"link", "status"=>"active"}, {"code"=>"schedule", "status"=>"active"}, {"code"=>"message", "status"=>"deactive"}, {"code"=>"bulletin", "status"=>"active"}, {"code"=>"cabinet", "status"=>"active"}, {"code"=>"memo", "status"=>"deactive"}, {"code"=>"phonemessage", "status"=>"deactive"}, {"code"=>"timecard", "status"=>"deactive"}, {"code"=>"todo", "status"=>"active"}, {"code"=>"address", "status"=>"deactive"}, {"code"=>"mail", "status"=>"deactive"}, {"code"=>"workflow", "status"=>"active"}, {"code"=>"report", "status"=>"active"}, {"code"=>"cbwebsrv", "status"=>"deactive"}, {"code"=>"rss", "status"=>"deactive"}, {"code"=>"cbdnet", "status"=>"deactive"}, {"code"=>"presence", "status"=>"deactive"}, {"code"=>"star", "status"=>"deactive"}, {"code"=>"notification", "status"=>"deactive"}, {"code"=>"cellular", "status"=>"deactive"}, {"code"=>"kunai", "status"=>"active"}, {"code"=>"favour", "status"=>"deactive"}, {"code"=>"dezielink", "status"=>"deactive"}]}

## Example: dump information of organizations and users

```ruby
require 'garoon-cat'
require 'json'

params = {
  endpoint:ENV['ENDPOINT'],
  username:ENV['USERNAME'],
  password:ENV['PASSWORD']
}

@base = GaroonCat::Service.new(params.merge({prefix:'cbpapi', name:'base' }))

# dump organization_versions
File.open('organization_versions.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_organization_versions())) }

# dump organizations
organization_ids = JSON.parse(File.read('organization_versions.json'))['organization_item'].map{ |e| e['id'] }
File.open('organizations.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_organizations_by_id(organization_id:organization_ids))) }

# dump user_versions
File.open('user_versions.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_user_versions())) }

# dump users
user_ids = JSON.parse(File.read('user_versions.json'))['user_item'].map{ |e| e['id'] }
File.open('users.json', 'wb'){ |io| io.write(JSON.pretty_generate(@base.get_users_by_id(user_id:user_ids))) }
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
