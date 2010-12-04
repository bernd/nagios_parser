require 'bundler'
Bundler::GemHelper.install_tasks

desc 'Generate the parser with racc'
task :parser => ['lib/nagios_parser/status/parser.rb']

rule '.rb' => '.y' do |target|
  sh "racc -v -o #{target.name} #{target.source}"
end
