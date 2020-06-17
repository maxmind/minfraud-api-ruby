lib = File.expand_path('lib', File.dirname(File.realpath(__FILE__)))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minfraud/version'

Gem::Specification.new do |spec|
  spec.name          = 'minfraud'
  spec.version       = Minfraud::VERSION
  spec.authors       = ['kushnir.yb']
  spec.email         = ['support@maxmind.com']

  spec.summary       = %q(Ruby interface to the MaxMind minFraud v2.0 API services)
  spec.homepage      = 'https://github.com/maxmind/minfraud-api-ruby'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 1.9'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '>= 0.9.1', '< 2.0'
  spec.add_runtime_dependency 'faraday_middleware', '>= 0.9.1', '< 2.0'

  spec.add_development_dependency 'bundler', '>= 1.16'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
