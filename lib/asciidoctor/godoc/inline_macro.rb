# frozen_string_literal: true

require "asciidoctor"
require "asciidoctor/extensions"

module Asciidoctor
  module Godoc
    # Provides the 'godoc' inline macro.
    # This macro allows asciidoc documents to reference
    # Go packages, types, functions, and methods
    # with fully-qualified import paths,
    # and generates links to their reference documentation.
    class InlineMacro < Asciidoctor::Extensions::InlineMacroProcessor
      use_dsl

      named :godoc
      name_positional_attributes "text"

      def pkgmap(attrs)
        pkgs = attrs["gopkgs"]
        return {} unless pkgs

        pkgs.split(/\s*;\s*/).to_h { |e| e.split(/\s*=\s*/) }
      end

      def generate_text(parent, importpath, id)
        # For just import paths,
        # use the import path as-is.
        return importpath unless id

        if id.split(".").count > 1
          # If the target is a method or a struct,
          # use $parent.$target.
          text = id
        else
          # Otherwise use $pkg.$target.
          pkg = pkgmap(parent.document.attributes)[importpath]
          pkg ||= importpath.split("/")[-1]
          text = "#{pkg}.#{id}"
        end

        node = create_inline parent, :quoted, text, { type: :monospaced }
        node.convert
      end

      def process(parent, target, attrs)
        importpath, id = target.split("#", 2)

        text = attrs["text"] || generate_text(parent, importpath, id)
        target = %(https://pkg.go.dev/#{importpath})
        target << "##{id}" if id

        parent.document.register :links, target
        (create_anchor parent, text, type: :link, target: target).convert.to_s
      end
    end
  end
end
