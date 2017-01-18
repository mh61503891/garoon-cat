# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'garoon-cat/version'

Gem::Specification.new do |spec|
  spec.name          = 'garoon-cat'
  spec.version       = GaroonCat::VERSION
  spec.authors       = ['Masayuki Higashino']
  spec.email         = ['mh.on.web@gmail.com']

  spec.summary       = %q{Garoon Cat: A Ruby interface to the Garoon API.}
  spec.description   = %q{Garoon Cat: A Ruby interface to the Garoon API.}
  spec.homepage      = 'https://github.com/mh61503891/garoon-cat'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency 'httpclient', '~> 2.8.3'
  spec.add_dependency 'http-cookie', '~> 1.0'
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'xml-simple', '~> 1.1'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-assert_errors'
  spec.add_development_dependency 'minitest-nyan-cat'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'guard-yard'
  spec.add_development_dependency 'awesome_print'
end
