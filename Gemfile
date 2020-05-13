source 'https://rubygems.org'

# coveralls fails on Ruby 1.9. My understanding is we don't need to run this on
# more than one version anyway, so restrict to the current latest.
version_pieces = RUBY_VERSION.split('.')
major_version = version_pieces[0]
minor_version = version_pieces[1]
if major_version == '2' && minor_version == '7'
  gem 'coveralls', require: false
end

gemspec
