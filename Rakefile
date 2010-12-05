require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rcov = false
end

desc 'Generate the parser with racc'
task :parser => ['lib/nagios_parser/status/parser.rb']

rule '.rb' => '.y' do |target|
  sh "racc -o #{target.name} #{target.source}"
end
