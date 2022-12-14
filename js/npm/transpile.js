'use strict'

const { Builder } = require('opal-compiler')
const fs = require('fs')

const transpiled = Builder
    .create()
    .build('../lib/asciidoctor/godoc/inline_macro.rb')
    .build('../lib/asciidoctor/godoc.rb')
    .toString()

fs.mkdirSync('dist', {recursive: true})
fs.writeFileSync('dist/index.js', transpiled)
