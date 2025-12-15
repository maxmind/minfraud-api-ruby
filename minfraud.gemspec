# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minfraud/version'

Gem::Specification.new do |spec|
  spec.name          = 'minfraud'
  spec.version       = Minfraud::VERSION
  spec.authors       = ['kushnir.yb', 'William Storey']
  spec.email         = ['support@maxmind.com']

  spec.summary               = 'Ruby API for the minFraud Score, Insights, Factors, and Report Transactions services'
  spec.homepage              = 'https://github.com/maxmind/minfraud-api-ruby'
  spec.license               = 'MIT'
  spec.metadata              = {
    'bug_tracker_uri'       => 'https://github.com/maxmind/minfraud-api-ruby/issues',
    'changelog_uri'         => 'https://github.com/maxmind/minfraud-api-ruby/blob/main/CHANGELOG.md',
    'documentation_uri'     => 'https://www.rubydoc.info/gems/minfraud',
    'homepage_uri'          => 'https://github.com/maxmind/minfraud-api-ruby',
    'rubygems_mfa_required' => 'true',
    'source_code_uri'       => 'https://github.com/maxmind/minfraud-api-ruby',
  }
  spec.required_ruby_version = '>= 3.2'

  spec.files = Dir['**/*'].difference(Dir['CLAUDE.md', 'CODE_OF_CONDUCT.md', 'dev-bin/**/*', 'Gemfile*', 'Rakefile', 'README.dev.md',
                                          'spec/**/*', '*.gemspec'])

  spec.add_dependency 'connection_pool', '~> 2.2'
  spec.add_dependency 'http', '>= 4.3', '< 6.0'
  spec.add_dependency 'maxmind-geoip2', '~> 1.4'
  spec.add_dependency 'simpleidn', '~> 0.1', '>= 0.1.1'

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.23'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'rubocop-thread_safety'
  spec.add_development_dependency 'webmock', '~> 3.14'
end
