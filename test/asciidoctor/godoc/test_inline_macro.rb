# frozen_string_literal: true

require "test_helper"

module Asciidoctor
  module Godoc
    class TestGodocInlineMacro < Minitest::Test
      def test_package_only
        assert_conversion "godoc:encoding/json[]",
                          '<a href="https://pkg.go.dev/encoding/json">encoding/json</a>'
      end

      def test_text_override
        assert_conversion "godoc:go/ast[ast package]",
                          '<a href="https://pkg.go.dev/go/ast">ast package</a>'
      end

      def test_formatted_text
        assert_conversion \
          "godoc:go/ast[`ast` package]",
          '<a href="https://pkg.go.dev/go/ast"><code>ast</code> package</a>'
      end

      def test_package_element
        assert_conversion "godoc:go.uber.org/zap#Logger[]",
                          '<a href="https://pkg.go.dev/go.uber.org/zap#Logger"><code>zap.Logger</code></a>'
      end

      def test_package_element_text_override
        assert_conversion "godoc:go.uber.org/zap#Logger[zap.Logger]",
                          '<a href="https://pkg.go.dev/go.uber.org/zap#Logger">zap.Logger</a>'
      end

      def test_package_element_formatted_text_override
        assert_conversion "godoc:go.uber.org/zap#Logger[`Logger`]",
                          '<a href="https://pkg.go.dev/go.uber.org/zap#Logger"><code>Logger</code></a>'
      end

      def test_package_import_path
        assert_conversion "godoc:go.uber.org/zap[]",
                          '<a href="https://pkg.go.dev/go.uber.org/zap">go.uber.org/zap</a>'
      end

      def test_package_element_field
        assert_conversion "godoc:testing#M.Run[]",
                          '<a href="https://pkg.go.dev/testing#M.Run"><code>M.Run</code></a>'
      end

      def test_import_path_with_dot
        assert_conversion "godoc:gopkg.in/yaml.v2[]",
                          '<a href="https://pkg.go.dev/gopkg.in/yaml.v2">gopkg.in/yaml.v2</a>'
      end

      def test_package_name_map
        assert_conversion \
          "godoc:gopkg.in/yaml.v2#Unmarshaler[]",
          '<a href="https://pkg.go.dev/gopkg.in/yaml.v2#Unmarshaler"><code>yaml.Unmarshaler</code></a>',
          { "gopkgs" => "gopkg.in/yaml.v2 = yaml; example.com/whatever-go.git = whatever;" }
      end

      def test_package_name_map_without_semicolon
        assert_conversion \
          "godoc:gopkg.in/yaml.v3#Unmarshaler[]",
          '<a href="https://pkg.go.dev/gopkg.in/yaml.v3#Unmarshaler"><code>yaml.Unmarshaler</code></a>',
          { "gopkgs" => "gopkg.in/yaml.v3 = yaml" }
      end

      def assert_conversion(give, want, attrs = {})
        doc = Asciidoctor::Document.new give.lines, {
          standalone: false,
          attributes: attrs
        }
        got = doc.convert

        assert_includes got, want
      end
    end
  end
end
