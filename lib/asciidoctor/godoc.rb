# frozen_string_literal: true

unless RUBY_ENGINE == 'opal'
  require "asciidoctor/extensions"
  require_relative "godoc/inline_macro"
  require_relative "godoc/version"
end

Asciidoctor::Extensions.register do
  inline_macro Asciidoctor::Godoc::InlineMacro
end
