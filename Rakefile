# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "asciidoctor"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

desc "Generates the GitHub Pages website"
task :site do
  $LOAD_PATH.unshift File.expand_path("./lib", __dir__)
  require "asciidoctor/godoc"
  Asciidoctor.convert_file "docs/home.adoc",
                           to_file: "_site/index.html",
                           standalone: true,
                           mkdirs: true,
                           safe: :safe,
                           attributes: {
                             "source-highlighter" => "rouge",
                             "reproducible" => "true",
                             "icons" => "font"
                           }
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]
