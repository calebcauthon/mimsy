require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/mimsy/*_spec.rb', 'spec/mimsy/lib/*_spec.rb']
  t.verbose = true
end