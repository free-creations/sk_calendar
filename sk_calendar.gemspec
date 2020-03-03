
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# note: requiring the version file here, will make this file invisible to 'SimpleCov' the code coverage analysis tool.
require 'sk_calendar/version'

Gem::Specification.new do |gem_spec|
  gem_spec.name          = 'sk_calendar'
  gem_spec.version       = SkCalendar::VERSION
  gem_spec.authors       = ['Harald Postner']
  gem_spec.email         = ['harald@free-creations.de']

  gem_spec.summary       = 'A generator for the singkreis calendar. '
  gem_spec.homepage      = 'https://github.com/free-creations/sk_calendar'
  gem_spec.license       = 'MIT'

  gem_spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem_spec.require_paths = ['lib']

  gem_spec.add_dependency 'i18n', '~> 1.0', '>= 1.0.1'
  gem_spec.add_dependency 'icalendar-rrule', '~> 0.1.6'
  gem_spec.add_dependency 'kramdown'

  gem_spec.add_development_dependency 'bundler', '~> 1.16'
  gem_spec.add_development_dependency 'rake', '>= 12.3.3'
  gem_spec.add_development_dependency 'rspec', '~> 3.7'
  gem_spec.add_development_dependency 'rubocop', '~> 0.55.0'
  gem_spec.add_development_dependency 'rubocop-rspec', '~> 1.24'
  gem_spec.add_development_dependency 'simplecov', '~> 0.16'
end
