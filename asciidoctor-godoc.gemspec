# frozen_string_literal: true

require_relative "lib/asciidoctor/godoc/version"

Gem::Specification.new do |spec|
  spec.name = "asciidoctor-godoc"
  spec.version = Asciidoctor::Godoc::VERSION
  spec.authors = ["Abhinav Gupta"]
  spec.email = ["mail@abhinavg.net"]

  spec.summary = "An Asciidoctor extension to add a 'godoc' macro."
  spec.description = "An Asciidoctor extension that adds support for \
    a 'godoc' macro to asciidoc documents. \
    This extension allows referencing Go entities in asciidoc documents, \
    linking to their documentation on https://pkg.go.dev."
  spec.homepage = "https://github.com/abhinav/asciidoctor-godoc"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abhinav/asciidoctor-godoc"
  spec.metadata["changelog_uri"] = "https://github.com/abhinav/asciidoctor-godoc/blob/main/CHANGELOG.adoc"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test)/|\.(?:git|github|bundle))})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "asciidoctor", [">= 2.0.0", "< 3.0.0"]
  spec.add_development_dependency "rake", "~> 13.0.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end
