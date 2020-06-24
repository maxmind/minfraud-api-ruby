# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new

task default: :spec

# The current version of rubocop supports Ruby 2.4+. While we could run its
# older versions, the config isn't backwards compatible. Let's run it only for
# 2.4+. This isn't perfect, but as long as 1.9+ tests pass we should be okay.
version_pieces = RUBY_VERSION.split('.')
major_version  = version_pieces[0]
minor_version  = version_pieces[1]
if major_version == '2' && minor_version.to_i >= 4
  task default: :rubocop
end
