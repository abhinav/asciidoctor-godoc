# frozen_string_literal: true

require "asciidoctor/extensions"
require_relative "godoc/inline_macro"
require_relative "godoc/version"

Asciidoctor::Extensions.register do
  inline_macro Asciidoctor::Godoc::InlineMacro
end
