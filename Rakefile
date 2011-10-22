require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.rcov = false
end

namespace :parser do
  desc 'Generate the status parser with racc'
  task :status => [ 'lib/nagios_parser/status/parser.rb' ]

  desc 'Generate the object parser with racc'
  task :object => [ 'lib/nagios_parser/object/parser.rb' ]

  desc 'Generate the resource parser with racc'
  task :resource => [ 'lib/nagios_parser/resource/parser.rb' ]

  desc 'Generate the main config parser with racc'
  task :config => [ 'lib/nagios_parser/config/parser.rb' ]

  rule '.rb' => '.y' do |target|
    sh "racc -o #{target.name} #{target.source}"
  end
end
